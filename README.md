# AWS Container

This repository provides a Docker container pre-configured with the AWS CLI and other useful tools for managing AWS services.
AWS HELP COMMAND 
aws iam help
aws iam help | grep user ( user related command)
detail : aws iam list-users help
        aws iam create-user help
        aws iam add-user-to-group help
aws iam list-users --query 'Users[].UserName' --output table
                                                       text (blank version) 
aws iam add-user-to-group \
  --user-name user-1 \
  --group-name S3-Support

verify group : aws iam list-groups-for-user --user-name user-1
if only want group name : 
aws iam list-groups-for-user \
  --user-name user-3 \
  --query 'Groups[].GroupName' \
  --output table

List incline policy for the group : aws iam list-group-policies --group-name EC2-Admin
aws iam list-attached-group-policies --group-name S3-Support


  


