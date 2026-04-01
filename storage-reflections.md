1. Explain how your app allows users to upload and view photos in your S3 bucket despite the fact that objects in S3 buckets are private by default and you did NOT apply any policies that would override that default.

    A prestigned URL can grants access S3 without uptading the bucket policy by using its IAM credentials. The app uses its own IAM credentials to generate a presigned URL and gives that URL to the user. So the user can upload or view their photos without needing their own AWS credentials or permissions.

2. Explain why the two GSIs you created are useful, and why the specific attributes used for the hash and range keys are the right choices for those GSIs. It may be helpful to read the comments in the upload_photo and toggle_privacy functions in app/flask/photos.py
    
    These two global secondary index are usefull because we need to perform a variety of different attributes as query. They let you query by attributes other then the base table. The hash and range key are exential for this global secondary index because they define an efficient access pattern. The hash key identifies which group of items to retrieve and the range key controls the order or subset within that group. This allows you yo look at tables in a much faster way without having an extensive full table.

