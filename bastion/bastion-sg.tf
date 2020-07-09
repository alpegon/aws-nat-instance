resource "aws_security_group" "bastion_ssh_sg" {
  name = "bastion_ssh"
  description = "Allow SSH to bastion instance host from approved ranges"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.ssh_ip_range]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = var.vpc_id
  tags = {
      Name = "terraform_bastion_ssh"
  }
}

output "bastion_ssh_sg_id" {
  value = aws_security_group.bastion_ssh_sg.id
}

resource "aws_security_group_rule" "private_subnet" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = aws_security_group.bastion_ssh_sg.id
  security_group_id = var.private_sg_id
}


resource "aws_security_group_rule" "nat_instance" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = aws_security_group.bastion_ssh_sg.id
  security_group_id = var.nat_sg_id
}