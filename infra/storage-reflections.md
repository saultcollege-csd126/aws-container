Reflection:

3.1 

--The app uses pre-signed S3 URLs so users can upload and view photos without making the S3 bucket public. These URLs are temporary links created by the app that give permission to access a specific file for a short time. This keeps the bucket private while still allowing users to use their photos.

3.2 

-- The two GSIs help the app find photos faster without searching the whole table. The user-photos-index uses user_id and uploaded_at, which helps show all photos from one user in order by upload date. The feed-index uses feed_key and uploaded_at, which helps show public photos in the main feed with the newest photos first. These keys are good choices because they organize the data and make searches faster.

