variable "ami" {
  default = "ami-0b1e2eeb33ce3d66f"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "availability_zones" {}

variable "key_name" {}

variable "public_subnet_id" {}

variable "public_subnet_eni_id" {}

variable "private_subnet_id" {}

variable "private_subnet_eni_id" {}

variable "nat_ssh_sg_id" {}




