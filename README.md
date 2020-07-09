# EC2 NAT instance in AWS

## Project overview
The following image gives you a high-level overview of the insfrastructure created with this project.

... 

## Required configuration

### Terraform
First you need terraform installed in your machine, information about this can be found [here](https://learn.hashicorp.com/terraform/getting-started/install.html).

### Terraform modules and plugins

Once you have terraform installed, you need to install the modules and plugins used in this project. To install them you only need to execute:
```
terraform init
```
in the root folder of this project.

### AWS cli
A configured aws cli is needed to avoid passing the aws variables to the terraform scripts. More information about configuring and installing the client [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

### tfvars file

To avoid storing configuration values that could give clues about our infrastructure, a `*.tfvars` file is required with the following variables: 
```
region = ""
# No spaces allowed between az names !
availability_zones = ["",""]
key_name = ""
vpc_id = ""
private_subnet_id = ""
private_sg_id = ""
private_route_table_id = ""
```

## Deploying the infrastructure

To deploy the infrastructure (assuming that your `tfvars` file is called `main.tfvars`), you only need to execute the command:
```
terraform apply -var-file=main.tfvars
```


## Deleting the infrastructure
To avoid incurring in extra costs, when you finish using the infrastructure, remember to delete the created resources with the command:
```
terraform destroy
```