provider "aws" {
  region = var.region
}

module "network" {
  source = "./network"
  vpc_id = var.vpc_id
  ip_range = var.ip_range
  private_subnet_id = var.private_subnet_id
  private_subnet_eni_ip = var.private_subnet_eni_ip
  private_sg_id = var.private_sg_id
  private_route_table_id = var.private_route_table_id
}

module "instances" {
  source = "./instances"
  public_subnet_id = module.network.public_subnet_id
  nat_ssh_sg_id = module.network.nat_ssh_sg_id
  public_subnet_eni_id = module.network.public_subnet_eni_id
  private_subnet_eni_id = module.network.private_subnet_eni_id
  private_subnet_cidr = var.private_subnet_cidr
  key_name = var.key_name
}