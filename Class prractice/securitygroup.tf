resource "aws_security_group" "atlas-sg" {
  name        = "allow_ssh_http_nfs"
  description = "allow ssh, https, and nfs inbound and all traffic for outbound"
  vpc_id      = aws_vpc.atlas-vpx.id

  tags = {
    Name = "allow_ssh_http_nfs_inbound"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_inbound" {
  security_group_id = aws_security_group.atlas-sg.id
  cidr_ipv4         = aws_vpc.atlas-vpx.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_inbound" {
  security_group_id = aws_security_group.atlas-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_nfs_inbound" {
  security_group_id = aws_security_group.atlas-sg.id
  cidr_ipv4         = aws_vpc.atlas-vpx.cidr_block
  from_port         = 2049
  ip_protocol       = "tcp"
  to_port           = 2049
}

resource "aws_vpc_security_group_egress_rule" "all_traffic_outbound" {
  security_group_id = aws_security_group.atlas-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

}