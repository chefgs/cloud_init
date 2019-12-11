# cloud_init
Introduction:
Expecting the readers should have basic understanding Chef cookbooks and related development experience.

Target audience for this demo,
Chef developers or teams looking to implement Chef in-spec script
Developers/testers looking to implement Chef Test Kitchen in real-time using AWS EC2 VM.

Objective:
Cookbook in this repo, does following steps
Below configurations are set when running the cookbok

Set a hostname on operating system level
Install a package called “my-monitoring-agent”. Assume that the package repository is already configured
Set the hostname in the configuration of the monitoring agent. Config file located at “/etc/mon-agent/agent.conf”
Ensure that the two users, “alice” and “bob”, exist and are part of the group “my-staff”

It has inspec test cases to verify the cookbook functionality.
The inspec test will be run inside a AWS EC2 VM, triggered via Chef Test Kitchen.

Pre-Requisites:
AWS Cloud Account
AWS (.pem) keypair should be pre-generated 

Workstation triggering the "Test Kitchen" should have following setup
Transfer the pem file into ~/.ssh path (file should have 600 mode).

Install ChefDK. If testing things other than Chef cookbooks, please consult your driver's documentation for information on what to install.

Install the AWS command line tools.

Run aws configure. This will set up your AWS credentials for both the AWS CLI tools and kitchen-ec2.

Checkout the cloud_init cookbook repo

Perform below changes in kitchen.yml sections:
driver:
  name: ec2
  aws_ssh_key_id: "name_of_pem_file_"
  region: us-west-2

transport:
  username: ubuntu
  ssh_key: ~/.ssh/gs-ubuntu-key.pem
 
Note: Since we are creating Ubuntu instance, user-name should be "ubuntu", otherwise use "ec2-user"

Now the cookbook is ready to run the following chef kitchen commands
Unit test command: chef exec rspec spec/
Linting and syntax check: chef exec cookstyle
Create test vm : chef exec kitchen create
Execute cookbook in test vm: chef exec kitchen converge
Run the inspec test cases in test vm: chef exec kitchen verify
Cleanup the test vm to save costs: chef exec kitchen destroy
End-to-end test run, which includes all the above commands: chef exec kitchen test

In general, use the kitchen test subcommand to verify the end-to-end quality of a cookbook.
Use the kitchen converge and kitchen verify subcommands during the normal the day-to-day development of a cookbook

## Cookbook functionality
Below configurations are set when running the cookbok 
- Set a hostname on operating system level 
- Install a package called “my-monitoring-agent”. Assume that the package repository is already configured 
- Set the hostname in the configuration of the monitoring agent. Config file located at “/etc/mon-agent/agent.conf” 
- Ensure that the two users, “alice” and “bob”, exist and are part of the group “my-staff” 
