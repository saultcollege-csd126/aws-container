Reflection:

39.1.	Explain why the ‘import’ blocks were important in this lab. Explain how they work, and how the process would be different if you were starting a project from scratch.

--Import blocks were important because the aws resources already existed. Terraform needs resources in its state file to manage them, so the import blocks connected my Terraform code to the existing resources. Without them, Terraform would try to create new ones. If I was starting from scratch, I wouldn’t need import blocks because Terraform would create everything itself.

39.2.   Consider how Terraform tracks the infrastructure state, and explain why you did NOT use Terraform to manage the secrets stored in the Parameter Store service.  Under what circumstances WOULD it be reasonable to use Terraform to manage these secrets?

--Terraform stores data in a state file, and secrets could be exposed there. That’s why we didn’t use it for secrets in this lab.It would only be okay to use Terraform for secrets if the state file is stored securely and access is restricted. 

