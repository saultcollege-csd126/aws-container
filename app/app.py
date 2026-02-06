"""Main Flask application for image sharing with AWS services"""
from flask import Flask, render_template, request, redirect, url_for, session, flash
from functools import wraps
import uuid
from werkzeug.utils import secure_filename
import os

from app.config import Config
from app.cognito_auth import CognitoAuth
from app.s3_storage import S3Storage
from app.dynamodb_metadata import DynamoDBMetadata


# Initialize Flask app
app = Flask(__name__)
app.config.from_object(Config)

# Initialize AWS service helpers
cognito_auth = CognitoAuth(
    user_pool_id=app.config['COGNITO_USER_POOL_ID'],
    client_id=app.config['COGNITO_CLIENT_ID'],
    client_secret=app.config['COGNITO_CLIENT_SECRET'],
    region=app.config['AWS_REGION']
)

s3_storage = S3Storage(
    bucket_name=app.config['S3_BUCKET_NAME'],
    region=app.config['AWS_REGION']
)

dynamodb_metadata = DynamoDBMetadata(
    table_name=app.config['DYNAMODB_TABLE_NAME'],
    region=app.config['AWS_REGION']
)


def allowed_file(filename):
    """Check if file extension is allowed"""
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']


def login_required(f):
    """Decorator to require login for routes"""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'username' not in session:
            flash('Please log in to access this page.', 'warning')
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function


@app.route('/')
def index():
    """Home page showing recent images"""
    result = dynamodb_metadata.get_recent_images(limit=12)
    images = []
    
    if result['success']:
        for item in result['items']:
            url_result = s3_storage.get_image_url(item['s3_key'])
            if url_result['success']:
                images.append({
                    'id': item['image_id'],
                    'url': url_result['url'],
                    'filename': item['original_filename'],
                    'owner': item['owner'],
                    'created_at': item['created_at']
                })
    
    return render_template('index.html', images=images)


@app.route('/login', methods=['GET', 'POST'])
def login():
    """Login page"""
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        
        result = cognito_auth.sign_in(username, password)
        
        if result['success']:
            session['username'] = username
            session['access_token'] = result['access_token']
            flash('Login successful!', 'success')
            return redirect(url_for('index'))
        else:
            flash(f'Login failed: {result.get("error", "Unknown error")}', 'danger')
    
    return render_template('login.html')


@app.route('/register', methods=['GET', 'POST'])
def register():
    """Registration page"""
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        email = request.form.get('email')
        
        result = cognito_auth.sign_up(username, password, email)
        
        if result['success']:
            flash('Registration successful! Please check your email for confirmation code.', 'success')
            return redirect(url_for('confirm', username=username))
        else:
            flash(f'Registration failed: {result.get("error", "Unknown error")}', 'danger')
    
    return render_template('register.html')


@app.route('/confirm', methods=['GET', 'POST'])
def confirm():
    """Email confirmation page"""
    username = request.args.get('username', '')
    
    if request.method == 'POST':
        username = request.form.get('username')
        confirmation_code = request.form.get('confirmation_code')
        
        result = cognito_auth.confirm_sign_up(username, confirmation_code)
        
        if result['success']:
            flash('Email confirmed! You can now log in.', 'success')
            return redirect(url_for('login'))
        else:
            flash(f'Confirmation failed: {result.get("error", "Unknown error")}', 'danger')
    
    return render_template('confirm.html', username=username)


@app.route('/logout')
def logout():
    """Logout"""
    session.clear()
    flash('You have been logged out.', 'info')
    return redirect(url_for('index'))


@app.route('/upload', methods=['GET', 'POST'])
@login_required
def upload():
    """Image upload page"""
    if request.method == 'POST':
        if 'file' not in request.files:
            flash('No file selected', 'danger')
            return redirect(request.url)
        
        file = request.files['file']
        
        if file.filename == '':
            flash('No file selected', 'danger')
            return redirect(request.url)
        
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            
            # Upload to S3
            s3_result = s3_storage.upload_image(
                file_obj=file.stream,
                filename=filename,
                content_type=file.content_type
            )
            
            if s3_result['success']:
                # Create metadata in DynamoDB
                image_id = str(uuid.uuid4())
                metadata_result = dynamodb_metadata.create_image_metadata(
                    image_id=image_id,
                    owner=session['username'],
                    original_filename=filename,
                    s3_key=s3_result['key']
                )
                
                if metadata_result['success']:
                    flash('Image uploaded successfully!', 'success')
                    return redirect(url_for('gallery'))
                else:
                    # Rollback S3 upload if metadata fails
                    s3_storage.delete_image(s3_result['key'])
                    flash(f'Failed to save metadata: {metadata_result.get("error")}', 'danger')
            else:
                flash(f'Upload failed: {s3_result.get("error")}', 'danger')
        else:
            flash('Invalid file type. Allowed: png, jpg, jpeg, gif, webp', 'danger')
    
    return render_template('upload.html')


@app.route('/gallery')
@login_required
def gallery():
    """User's image gallery"""
    result = dynamodb_metadata.get_user_images(session['username'])
    images = []
    
    if result['success']:
        for item in result['items']:
            url_result = s3_storage.get_image_url(item['s3_key'])
            if url_result['success']:
                images.append({
                    'id': item['image_id'],
                    'url': url_result['url'],
                    'filename': item['original_filename'],
                    'created_at': item['created_at']
                })
    
    return render_template('gallery.html', images=images)


@app.route('/delete/<image_id>', methods=['POST'])
@login_required
def delete_image(image_id):
    """Delete an image"""
    # Get image metadata to verify ownership
    metadata_result = dynamodb_metadata.get_image_metadata(image_id)
    
    if not metadata_result['success']:
        flash('Image not found', 'danger')
        return redirect(url_for('gallery'))
    
    item = metadata_result['item']
    
    # Verify ownership
    if item['owner'] != session['username']:
        flash('You do not have permission to delete this image', 'danger')
        return redirect(url_for('gallery'))
    
    # Delete from S3
    s3_result = s3_storage.delete_image(item['s3_key'])
    
    # Delete metadata from DynamoDB
    db_result = dynamodb_metadata.delete_image_metadata(image_id)
    
    if s3_result['success'] and db_result['success']:
        flash('Image deleted successfully', 'success')
    else:
        flash('Error deleting image', 'danger')
    
    return redirect(url_for('gallery'))


if __name__ == '__main__':
    # Debug mode should be disabled in production
    debug_mode = os.environ.get('FLASK_DEBUG', 'False').lower() == 'true'
    app.run(host='0.0.0.0', port=5000, debug=debug_mode)
