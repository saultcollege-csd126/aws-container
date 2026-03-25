1st Question

The infrastructure already existed in AWS from previous assignments, so running terraform apply would have caused terraform to create everything again from scratch. Import blocks let us tell Terraform which existing AWS resource each config block so it just records it in the state file without touching anything. If you start from scratch none of this is needed, you just write the config and apply it directly.

2nd Question

Terraform stores everything in a plain text including resource values. Managing secrets through terraform would leave their values in that file which is a security risk. So we keep them locally. It would be reasonable to manage secrets if the state file is stored in a properly encrypted place.