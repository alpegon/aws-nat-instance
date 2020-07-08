variable "vpc_id" {}

variable "public_subnet_cidr" {
  default = "10.0.10.0/24"
}

variable "public_subnet_eni_ip" {
  default = "10.0.10.10"
}

variable "private_subnet_id" {}

variable "private_subnet_eni_ip" {}

variable "private_sg_id" {}

variable "private_route_table_id" {}

variable "availability_zones" {
  # No spaces allowed between az names!
  default = ["us-west-2a","us-west-2b","us-west-2c"]
}

variable "ip_range" {
  default = "0.0.0.0/0" # Change to your IP Range!
}