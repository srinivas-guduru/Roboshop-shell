#!/bin/bash

SG_ID="sg-0963b9b26e0964ab9"
AMI_ID="ami-0220d79f3f480ecf5"

for instance in $@
do
    instance_id= $( aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type "t3.micro"\
    --security-group-ids $SG_ID \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
    --query 'Instances[0].InstanceId' \
    --output text )

if [ $instance == "fornted" ]; then
   IP=$(
    aws ec2 decribe-instance \
    --instance-ids $instance_id\
    --query 'Reservations[].instances[].PublicIpAddress'\
    --output text
         )
   else
      IP=$(
    aws ec2 decribe-instance \
    --instnance-ids $instance_id\
    --query 'Reservations[].instances[].PrivateIpAddress'\
    --output text
         )
fi

  echo "IP Adress: $IP"
done
