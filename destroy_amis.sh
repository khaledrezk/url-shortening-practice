#!/bin/bash

region="us-east-1"

ami_id=`aws ec2 describe-images \
    --region $region \
    --owner self \
    --query 'Images[*].[ImageId]' \
    --output text` 

echo "Will deregister image :$ami_id"

aws ec2 deregister-image --image-id $ami_id --region $region

snapshot_id=`aws ec2 describe-snapshots \
    --region $region \
    --owner self \
    --query 'Snapshots[*].[SnapshotId]' \
    --output text`

echo "Will delete snapshot :$snapshot_id"
aws ec2 delete-snapshot \
    --region $region \
    --snapshot-id $snapshot_id

