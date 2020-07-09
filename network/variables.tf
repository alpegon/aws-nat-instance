variable "availability_zones" {}

variable "vpc_id" {}

variable "private_subnet_id" {}

variable "private_sg_id" {}

variable "private_route_table_id" {}

variable "ip_range" {
  default = "0.0.0.0/0" # Change to your IP Range!
}