variable "ssh_ip_range" {
  default = "0.0.0.0/0" # Change to your IP Range!
}

variable "region" {
  default = "us-west-2"
}

variable "availability_zones" {
  default = ["us-west-2a"]
}

# An Amazon Linux AMI is required for the configuration script 'user_data.sh' to work
variable "ami" {
  default = "ami-0b1e2eeb33ce3d66f"
}

variable "instance_type" {
  default = "t2.micro"
}


variable "key_name" {}

variable "vpc_id" {}

variable "private_subnet_id" {}

variable "private_sg_id" {}

variable "private_route_table_id" {}
