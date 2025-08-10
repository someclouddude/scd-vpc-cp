data "aws_ami" "fck_nat_arm64" {
  most_recent = true
  owners      = ["self", "aws-marketplace", "125523088429"] # fck-nat publisher
  filter {
    name   = "name"
    values = ["fck-nat-arm64-*", "fck-nat-*-arm64-*"]
  }
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}
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
  ami           = data.aws_ami.fck_nat_arm64.id
  instance_type = var.nat_instance_type
  subnet_id     = aws_subnet.public[count.index].id
  associate_public_ip_address = true
  source_dest_check           = false
  vpc_security_group_ids      = [aws_security_group.nat.id]
  tags = { Name = "nat-${count.index + 1}" }
}
