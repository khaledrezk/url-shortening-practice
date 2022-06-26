#!/bin/bash

#Provision the terraform infrastructure on aws and get the outputs in a config file to use by others. 
#Saving the database password is still insecure TODO refactor to make the password only on the docker containers or use IAM instead. 

cd terraform

terraform init
terraform apply -auto-approve
terraform output -json > ../app/.terraform_out.json
