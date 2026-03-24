1. Explain why the ‘import’ blocks were important in this lab. Explain how they work, and how the process would be different if you were starting a project from scratch.

Using the import blocks we declare the AWS infrastructure into Terraform's state, every resource was imported in order to make the process more repeatable and reviewable for the workflow. this method allows to have an easier management of existing infrastructure than for instance starting a project from scratch. Furthermore, It is important to resalt that once you create the import blocks, you avoid the importing commands process, which saves you a lot of time. 

2. Consider how Terraform tracks the infrastructure state, and explain why you did NOT use Terraform to manage the secrets stored in the Parameter Store service.  Under what circumstances WOULD it be reasonable to use Terraform to manage these secrets?

Keeping on mind that in a real context probably many people will have access to the state file, that also means that all of them will have access to all the sensitive information that you place in the Parameter Store or that you want to manage in Terraform. 
Also, sensitive information (passwords, API keys, tokens, etc.) is usually made on the idea to be updated or rotated, idea that is not applied in Terraform because is a declarative infrastructure. 
However, If we want to create a context where is reasonable to place this sensitive information in our Terraform infrastructure it would be under the concept that you stored the secrets as SecureString in Parameter Store, if you never output the secret value in terraform and use remote state at the same time. the encryption will reduce the risk, making this method more reasonable. 


