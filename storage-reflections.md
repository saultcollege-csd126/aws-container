# Reflections

1. How my app allows users to upload and view photos in my S3 bucket despite the fact that objects in S3 buckets are private by default:

The S3 bucket is private, means that normally nobody can upload or see files. But the app still works because it uses pre-signed URLs. It works because the backend creates a special link that gives permission for a short time. When the user wants to upload a photo, the app gives them this link and they upload the image directly to S3 using it. Same thing when viewing photos, the app creates another temporary link so the image can be seen.

2. Why the two GSIs you created are useful, and why the specific attributes used for the hash and range keys are the right choices for those GSIs.

The main reason why GSIs are helpful in programs like this is becasue they allow us to find data in efficient ways, these are real examples during the lab: 

- User-photos-index, uses user_id and uploaded_at. This helps to get all photos from one user and show them in order (like 'newest first'). As result, we get a website much more organized.

- Feed-index, uses feed_key and uploaded_at. This helps to show photos in the main feed. The feed_key groups the photos, and uploaded_at lets us sort them by time. 