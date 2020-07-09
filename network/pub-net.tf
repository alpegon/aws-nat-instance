#
# Create IGW to provide external internet functionality
#
resource "aws_internet_gateway" "default" {
  vpc_id = var.vpc_id
  tags = {
      Name = "terraform_igw"
  }
}

#
# Public Subnet
#
data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "aws_subnet" "public_subnet" {
  vpc_id = var.vpc_id
  cidr_block = cidrsubnet(data.aws_vpc.selected.cidr_block, 8, 1)
  availability_zone = element(var.availability_zones, 0)
  tags = {
      Name = "terraform_public_subnet"
  }
}
output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

resource "aws_route_table" "public_subnet" {
  vpc_id = var.vpc_id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.default.id
  }
  tags = {
      Name = "terraform_public_subnet_route_table"
  }
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_subnet.id
}

#
# Route added to the private route table. The table must exist.
#
resource "aws_route" "r" {
  route_table_id            = var.private_route_table_id
  destination_cidr_block    = "0.0.0.0/0"
  network_interface_id = aws_network_interface.private_subnet_eni.id
}
