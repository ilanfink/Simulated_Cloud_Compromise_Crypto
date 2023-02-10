# Simulated_Cloud_Compromise_Crypto

This Repo is intended to create actions that simulate a compromise of an AWS Cloud Environment. 

The simulation is meant to be used for security and operations teams to improve their response capabilities.

It is written in 3 parts, as to create opportunities to seperate events and logs for more in depth searching. 

Order of scripts:
1. Recon -> calls multiple AWS api's and can be set to run on as a cronjob to create noise and evidence 
2. Escalation -> creates user, assigns permissions and generates CLI secret and secret key for later use
3. Exploit -> creates EC2 instances for simulated cryptomining activity

These scripts are demos of some of the potential IOC's in an account where malicious actors deploy new EC2 instances or utilize existing instances to mine cryptocurrency in the background. 

These scripts are in no way intended to be used for malicious activity and use for anything other than training or education purposes is prohibited.
