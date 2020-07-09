variable "ip_range" {
  default = "0.0.0.0/0" # Change to your IP Range!
}
#
# Private Network Variables. Modify to your needs
#
variable "region" {}

variable "availability_zones" {}

variable "key_name" {}

variable "vpc_id" {}

variable "private_subnet_id" {}

variable "private_sg_id" {}

variable "private_route_table_id" {}