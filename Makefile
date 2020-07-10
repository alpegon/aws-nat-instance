## Makefile for deploying the terraform configuration

install:
	terraform init

deploy:
	terraform apply -var-file=main.tfvars -target=module.instances -target=module.network

destroy:
	terraform destroy -var-file=main.tfvars	

deploy-all:
	terraform apply -var-file=main.tfvars

deploy-bastion:
	terraform apply -var-file=main.tfvars -target=module.bastion

destroy-bastion:
	terraform destroy -var-file=main.tfvars -target=module.bastion

