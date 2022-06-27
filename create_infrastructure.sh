#!/bin/bash

#Provision the terraform infrastructure on aws and get the outputs in a config file to use by others. 
#Saving the database password is still insecure TODO refactor to make the password only on the docker containers or use IAM instead. 
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
terraform apply -auto-approve
terraform output -json > ../app/.terraform_out.json
