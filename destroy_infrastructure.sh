#!/bin/bash

#Destroy all aws infrastructure including the s3 bucket.
#Not good to use in production but
#Will use it frequently to avoid aws costs.

terraform_s3_bucket="terraform-primary"
key_pair="ec2_ssh"
cd terraform
terraform destroy -auto-approve

aws ec2 delete-key-pair --key-name $key_pair
aws s3 rm s3://$terraform_s3_bucket --recursive
aws s3api delete-bucket --bucket $terraform_s3_bucket --region us-east-1

cd ..
./destroy_amis.sh