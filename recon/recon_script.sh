echo "enumerating users, groups, roles, privileges"

# deleting existing files to conserve disk space
rm -rf <path/to/local/dir/here>

#creating directory to store recon file
mkdir -p <path/to/local/dir/here>

cd <path/to/local/dir/here>

echo "Shady shit file:" >> <filename.txt>

echo "My User:" >> recon.txt
aws iam get-user --profile svc >> recon.txt

echo "All Users:" >> recon.txt
aws iam list-users --profile svc >> recon.txt

echo "All Groups:" >> recon.txt
aws iam list-groups --profile svc >> recon.txt

echo "Generating Credential Report"
aws iam generate-credential-report --profile svc 

echo "Credential Report encrypted in Base64" >> recon.txt
aws iam get-credential-report --profile svc >> recon.txt

regions=(<regions to enumerate here>)

for i in ${regions[@]}
do
	aws ec2 describe-vpcs --region $i --profile svc >> recon.txt;
done

vpcs=(<vpc ids with quotes here>)
for j in ${vpcs[@]}
do 
	for i in ${regions[@]}
	do
	aws ec2 describe-subnets --profile svc \
		--filters "Name=vpc-id,Values=$j" --region $i >> recon.txt;
	done
done
