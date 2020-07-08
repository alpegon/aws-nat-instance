resource "aws_security_group" "nat_ssh_sg" {
  name = "nat_ssh"
  description = "Allow SSH to Nat instance host from approved ranges"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.ip_range]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = var.vpc_id
  tags = {
      Name = "terraform_nat_ssh"
  }
}

output "nat_ssh_sg_id" {
  value = aws_security_group.nat_ssh_sg.id
}