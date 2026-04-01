 Terraform Reflection

 Why were import blocks important in this lab?

Import blocks were important because the AWS infrastructure had already been created before Terraform was used. Instead of creating new resources, Terraform needed a way to connect the existing AWS resources to the Terraform configuration. Import blocks allow Terraform to bring existing resources into its state so they can be managed without being recreated.

If this project were started from scratch, import blocks would not be necessary because Terraform would create the infrastructure directly and manage it from the beginning.

 Why were secrets not managed with Terraform?

Terraform stores infrastructure data in its state file, which can include sensitive information. If secrets such as API keys or passwords were stored in Terraform, they could be exposed if the state file is not properly secured.

It would only be appropriate to manage secrets with Terraform if the state is stored securely (for example, encrypted remote storage with restricted access). Even then, it should be done carefully.