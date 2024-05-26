resource "aws_instance" "vm1test" {
  ami                    = var.ami_id
  availability_zone      = var.az
  key_name               = var.key
  instance_type          = var.instance_type
  vpc_security_group_ids = ["aws_security_group.sgtest.id"]

  depends_on = [aws_security_group.sgtest]

  tags = {
    Name = "atlasec2tf"
  }
}

resource "aws_security_group" "sgtest" {
  name        = "all_http"
  description = "allow inbound and outbound traffic"

  tags = {
    Name = "sgtest12"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.sgtest.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.sgtest.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}