resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "terraform_bastion"
  }
  subnet_id = var.public_subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.bastion_ssh_sg.id]
  key_name      = var.key_name
}