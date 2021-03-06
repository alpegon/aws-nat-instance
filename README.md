# EC2 NAT instance in AWS

## Project overview
This configuration assumes that you already have a VPC, a private subnet, some VMs in the private subnet, a private security group for those machines, and a private route table. The following image shows the expected infrastructure:

![Expected infrastructure](images/init-infrastructure.png)

The terraform configuration of this project creates an EC2 machine and its required network resources to use it as a Nat instance. Additionally it creates a bastion host to simplify the management of the other machines. The image below shows the infrastructure created by terraform:

![Created infrastructure](images/end-infrastructure.png)

As a summary this configuration does the following:

* Creates nat security group
* Creates an internet gateway
* Creates an elastic network interface (ENI) in the private subnet
* Creates a public subnet
* Creates a public route table with a default route to the internet gateway
* Creates an ENI in the public subnet
* Adds a rule to redirect the traffic of the private subnet to the private ENI created before
* Associates the public subnet with the internet gateway in the public route table
* Creates the EC2 nat instance and provisions it with the user script. Additionally attaches the created ENIs to the intance.
* Creates an elastic IP and assigns it to the public ENI attached to the nat instance

And additionally, if you deploy the bastion host:

* Creates a security group inside the public subnet for the bastion instance
* Opens the port 22 in the security groups of the nat instance and the private subnet
* Deployes the EC2 instance inside the bastion security group with a public IP

## Required tools and files

### Make
To simplify the management of the configuration modules, a Makefile has been created. You can still execute the terraform deployment without the make library but it implies using longer commands.

### Terraform
First you need terraform installed in your machine, information about this can be found [here](https://learn.hashicorp.com/terraform/getting-started/install.html).

### Terraform modules and plugins

Once you have terraform installed, you need to install the modules and plugins used in this project. To install them you only need to execute:
```
make install
```
in the root folder of this project.

### AWS cli
A configured aws cli is needed to avoid passing the aws variables to the terraform scripts. More information about configuring and installing the client [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

### tfvars file

To avoid storing configuration values that could give clues about our infrastructure, a `main.tfvars` file is required with the following variables: 
```
key_name = ""
vpc_id = ""
private_subnet_id = ""
private_sg_id = ""
private_route_table_id = ""
```

The `key_name` variable is the **name** of your ssh key used to manage the EC2 instances. You don't need to pass explicitly any key.

You can also modify the variables in the file `variables.tf` to adapt the configuration to your needs. Take into account that the script created to configure the nat instance has been tested in an Amazon Linux AMI and could not work in other instance type.

## Deploying the infrastructure

To deploy the infrastructure (assuming that you have a `tfvars` file called `main.tfvars` in the root folder of the project), you only need to execute the command:
```
make deploy
```


## Deleting the infrastructure
To avoid incurring in extra costs, when you finish using the infrastructure, remember to delete the created resources with the command:
```
make destroy
```

## Upgrading the infrastructure

### Scalability and High-Availability

The easiest way to escale the nat instance is to vertically scale the machine, which can be easily achieved by changing the `instance_type` variable in the `variables.tf` file.  

This terraform configuration only deploys one nat instance in one availability zone and links it with one private subnet. If you have several private subnets in several availability zones, the recommended strategy to follow is to deploy one nat instance for each availability zone in use, and then make the nat instances to monitor each other. In case one of the instances goes down, the other instances should have the rights to power on and reconfigure a new instance in the availability zone where the machine has failed.

More information about this use case can be found [here](https://aws.amazon.com/articles/high-availability-for-amazon-vpc-nat-instances-an-example/).

Also to improve maintenance, terraform can be combined with **ansible** to offer better provisioning capabilities. Using ansible would allow us to rewrite the nat instance configuration as an ansible role an thus give support for other instance types. This terraform + ansible combination gives the user more flexibility to define infrastructures and decouples the provisioning code from the infrastructure definition code.

### Increase the security

If you deploy the infrastructure with the `make deploy-all` command, a bastion host is also deployed for managing the nat instance and accessing the machines in the private subnet. To increase the security you can delete the bastion host with the command:

```
make delete-bastion
```
Take into account that you will need other method (like a private vpn) to access the instances of the private subnet.

If you want to redeploy the bastion instance, you only have to execute:
```
make deploy-bastion
```

### More security !!

You can also modify the script `instances/user_data.sh.tpl` to add more iptables rules, like logging the dropped packages of the filter table, or antispoofing filtering in the prerouting chain of the nat table.

Check the next section to know how to update the instance with the new rules.


### Whitelisting ports without accessing the nat instance

To be able to share the configuration state and thus, to allow user to update the infrastructure without having to manually copying the `*.tfstate` file, you can use the **remote state** feature of terraform. In this case, you could use a S3 backend shared by all the users. More information about this [here](https://www.terraform.io/docs/backends/types/s3.html).

Once the remote state is configured, the users can modify the script in `instances/user_data.sh.tpl` to modify the firewall or the nat configuration as needed.

Once the script file has been changed, the new infrastructure can be updated with the command:

```
make deploy
```

Be aware that **you will not have external internet access** from your private network while the instance is being redeployed (~ 3 minutes of downtime).