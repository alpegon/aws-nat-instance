resource "aws_network_interface" "public_subnet_eni" {
  subnet_id       = aws_subnet.public_subnet.id
  private_ips     = [var.public_subnet_eni_ip]
  security_groups = [aws_security_group.nat_ssh_sg.id]
  source_dest_check = false
  tags = {
    Name = "terraform_public_eni"
  }
}

output "public_subnet_eni_id" {
  value = aws_network_interface.public_subnet_eni.id
}

output "public_subnet_eni_ip" {
  value = aws_network_interface.public_subnet_eni.id
}

resource "aws_network_interface" "private_subnet_eni" {
  subnet_id       = var.private_subnet_id
  private_ips     = [var.private_subnet_eni_ip]
  security_groups = [var.private_sg_id]
  source_dest_check = false
  tags = {
    Name = "terraform_private_eni"
  }
}

output "private_subnet_eni_id" {
  value = aws_network_interface.private_subnet_eni.id
}