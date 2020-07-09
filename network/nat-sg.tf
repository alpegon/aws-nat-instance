resource "aws_security_group" "nat_sg" {
  name = "nat_sg"
  description = "SG for the Nat instance. No input connections allowed."
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = var.vpc_id
  tags = {
      Name = "terraform_nat"
  }
}

output "nat_sg_id" {
  value = aws_security_group.nat_sg.id
}