provider "aws" {
  region = var.region
}

module "network" {
  source = "./network"
  vpc_id = var.vpc_id
  availability_zones = var.availability_zones
  private_subnet_id = var.private_subnet_id
  private_sg_id = var.private_sg_id
  private_route_table_id = var.private_route_table_id
}

module "instances" {
  source = "./instances"
  availability_zones = var.availability_zones
  ami = var.ami
  instance_type = var.instance_type
  public_subnet_id = module.network.public_subnet_id
  private_subnet_id = var.private_subnet_id
  public_subnet_eni_id = module.network.public_subnet_eni_id
  private_subnet_eni_id = module.network.private_subnet_eni_id  
  key_name = var.key_name
}

module "bastion" {
  source = "./bastion"
  vpc_id = var.vpc_id
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  ssh_ip_range = var.ssh_ip_range
  public_subnet_id = module.network.public_subnet_id
  private_sg_id = var.private_sg_id
  nat_sg_id = module.network.nat_sg_id
}