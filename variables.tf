variable "region" {
  default = "us-west-2"
}

variable "key_name" {
  default = "terraform"
}

variable "ip_range" {
  default = "0.0.0.0/0" # Change to your IP Range!
}

variable "availability_zones" {
  # No spaces allowed between az names!
  default = ["us-west-2a","us-west-2b","us-west-2c","us-west-2d"]
}

variable "vpc_id" {
    default = "vpc-024f8b25cc4a8a356"
}

variable "public_subnet_cidr" {
  default = "10.0.10.0/24"
}

variable "public_subnet_eni_ip" {
  default = "10.0.10.10"
}

#
# Private Network Variables. Modify to your needs
#

variable "private_subnet_cidr" {
  default = "10.0.11.0/24"
}

variable "private_subnet_eni_ip" {
  default = "10.0.11.10"
}

variable "private_subnet_id" {
  default = "subnet-019605288f7200950"
}

variable "private_sg_id" {
  default = "sg-051b7bfa50ceda1e2"
}

variable "private_route_table_id" {
  default = "rtb-0de5438f51bc40db7"
}