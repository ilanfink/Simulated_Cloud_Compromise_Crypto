#lambda to launch EC2
import boto3
import os
ec2 = boto3.resource('ec2')

INSTANCE_TYPE = os.environ['INSTANCE_TYPE'] #These will be environment variables that we must specify in lambda
KEY_NAME = os.environ['KEY_NAME']
AMI=os.environ['AMI']
SUBNET_ID=os.environ['SUBNET_ID']

init_script = """#!/bin/bash
                 test1=$(ps fax | grep 'stress -q' | grep -v 'grep' | wc -l)
                 #echo "$test1"

                 if ! command -v stress &> /dev/null; then
                    sudo amazon-linux-extras install epel -y
                    sudo yum install stress -y
                 else
                    if [[ $test1 -gt 0 ]]; then
                        echo 'stress running, aborting'
                    else
                        echo 'running stress test now...'
                        stress -q -c $(( $RANDOM % 40 + 1 ))
                    fi
                 fi"""

def lambda_handler(event, context):   #Start of our function
    instance = ec2.create_instances(
        InstanceType=INSTANCE_TYPE,
        KeyName=KEY_NAME,
        ImageId=AMI,
        SubnetId=SUBNET_ID,
        MaxCount=15,
        MinCount=10,
        UserData=init_script,
        TagSpecifications=[{    #This creates a tag for our resource
            'ResourceType': 'instance',
            'Tags': [{'Key': 'Name','Value': 'Default'}]
        }]   
    )
    print("New instance created:", instance[0].id)