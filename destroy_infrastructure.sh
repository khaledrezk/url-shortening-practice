#!/bin/bash

#Destroy all aws infrastructure including the s3 bucket.
#Not good to use in production but
#Will use it frequently to avoid aws costs.

terraform_s3_bucket="terraform-primary"

cd terraform
terraform destroy -auto-approve

aws s3 rm s3://$terraform_s3_bucket --recursive
aws s3api delete-bucket --bucket $terraform_s3_bucket --region us-east-1