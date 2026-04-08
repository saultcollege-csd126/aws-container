## 1. Why were import blocks important in this lab?

Import blocks were important in this lab because the AWS infrastructure already existed before Terraform was introduced. The import blocks allowed Terraform to connect the existing AWS resources to the resource blocks in the Terraform configuration instead of trying to create new resources

## 2. Why did you not use Terraform to manage secrets in Parameter Store? Under what circumstances would it be reasonable to do so?

Terraform stores infrastructure information in the `terraform.tfstate` file. If secret values are managed directly by Terraform, those secrets may also be stored in the state file, which can be a security risk if the file is exposed or accidentally committed to version control.

