##1
import blocks were important to the lab because we were, well, importing existing infrastructure.
We didn't want to lose all of our previous work and configurations. The import blocks work by making API
calls to the specified provider using your credentials and the resource's ids, to populate the configuration information so Terraform has a 
complete picture of your infrastructure and all the information it needs to modify/access the services as it needs to later on (that's why we're configuring it, after all, unless
I'm completely mistaken).
If we were starting a project from scratch we'd follow many similar steps but it would be working through Terraform to generate new infrastructure instead of "roping in" existing infrastructure.


##2.
First of all- you are reading this on GitHub (maybe), which is not a good place for secret keys to end up. Also, they can end up in output of commands, as they're are unencrypted and stored as plain text. It would be reasonable to store them in Terraform if they were accessed via an ephemeral block which is deleted aftern the session, or if there were increased security measures used (encryption w/ the 'sensitive' argument that can be added to variables, using data blocks to fetch only when needed). 