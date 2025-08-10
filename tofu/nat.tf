resource "aws_security_group" "nat" {
  name        = "nat-sg"
  description = "Allow outbound for NAT instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "nat-sg" }
}

resource "aws_instance" "nat" {
  count         = var.az_count
  ami           = var.nat_ami_id
  instance_type = var.nat_instance_type
  subnet_id     = aws_subnet.public[count.index].id
  associate_public_ip_address = true
  source_dest_check           = false
  vpc_security_group_ids      = [aws_security_group.nat.id]
  tags = { Name = "nat-${count.index + 1}" }
}
