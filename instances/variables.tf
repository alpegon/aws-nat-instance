variable "ami" {
  default = "ami-0b1e2eeb33ce3d66f"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {}

variable "public_subnet_id" {}

variable "availability_zones" {
  # No spaces allowed between az names!
  default = ["us-west-2a","us-west-2b","us-west-2c","us-west-2d"]
}

variable "nat_ssh_sg_id" {}

variable "public_subnet_eni_ip" {
  default = "10.0.10.10"
}

variable "public_subnet_eni_id" {}

variable "private_subnet_cidr" {}

variable "private_subnet_eni_id" {}
