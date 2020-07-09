data "aws_subnet" "selected" {
  id = var.private_subnet_id
}

data "template_file" "init_nat" {
  template = file("./instances/user_data.sh.tpl")

  vars = {
    private_subnet_cidr = data.aws_subnet.selected.cidr_block
  }
}

resource "aws_instance" "nat" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  availability_zone = element(var.availability_zones, 0)

  network_interface {
      device_index         = 0
      network_interface_id = var.public_subnet_eni_id
  }

  network_interface {
      device_index         = 1
      network_interface_id = var.private_subnet_eni_id
  }

  user_data = data.template_file.init_nat.rendered

  tags = {
    Name = "terraform_nat"
  }
}

output "nat_instance_id" {
  value = aws_instance.nat.id
}

# Although the elastic IP is related to the public subnet elastic network interface,
# if you don't use the depends_on attribute, it will fail when attaching the eip to
# the nat intance
resource "aws_eip" "nat_eip" {
  vpc                       = true
  network_interface         = var.public_subnet_eni_id
  tags = {
      Name = "terraform_nat_eip"
  }
  depends_on = [
    aws_instance.nat
  ]  
}