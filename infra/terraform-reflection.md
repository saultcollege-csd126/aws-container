Question #1:

Import blocks were important in the lab because the way they connected from the container to AWS. The way the block work is that they sync up with the already existing infastructure and they state the files to another resource. I you had to start from stratch what you would do is create a resource block and then a import block to do this.


Question #2:

Terraform tracks data by storing it to a plain text state file and which it creates a high security if somehow the backend is not configured correctly. It is usaully reasonable to use terraform for secrets when a remote state backend with strict IAM permission.