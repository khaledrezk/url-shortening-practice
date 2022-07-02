#!/bin/bash

#Provision the terraform infrastructure on aws and get the outputs in a config file to use by others. 
#Saving the database password is still insecure TODO refactor to make the password only on the docker containers or use IAM instead. 

#add new ec2 ssh key.
mkdir -p keys
rm -rf ./keys/*
ssh-keygen -t rsa -b 2048 -f ./keys/ec2 -N ""

#Create s3 bucket if doesn't exist
terraform_s3_bucket="terraform-primary"
if aws s3api head-bucket --bucket "$S3_BUCKET" 2>/dev/null;then
    echo "Terraform backend bucket exists!";
else
    echo "Creating bucket...";
    aws s3api create-bucket \
    --bucket $terraform_s3_bucket \
    --region us-east-1;
    echo "Created terraform backend!";
fi

cd terraform

terraform init
#Create db first as we will need it for server
terraform apply -target=aws_db_instance.default -auto-approve
terraform output -json > ../app/.terraform_out.json
#Copy the codebase to /tmp/repo
REPO_PATH="/tmp/repo"
rm -rf $REPO_PATH
cp -r .. $REPO_PATH
rm $REPO_PATH/terraform/.terraform -rf # Huge directory and can be generated when needed.

#Apply remaining steps
terraform apply -auto-approve