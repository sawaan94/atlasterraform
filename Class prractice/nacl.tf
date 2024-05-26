resource "aws_network_acl" "atlasnacl" {
  vpc_id = aws_vpc.atlas-vpx.id

  tags = {
    Name = "atlas-nacl"
  }

}

resource "aws_network_acl_rule" "allow_inbound_https" {
  network_acl_id = aws_network_acl.atlasnacl.id
  rule_number    = 101
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443

}

resource "aws_network_acl_rule" "allow_outbound_all" {
  network_acl_id = aws_network_acl.atlasnacl.id
  rule_number    = 102
  egress         = true
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 6535

}

resource "aws_network_acl_rule" "allow_inbound_ssh" {
  network_acl_id = aws_network_acl.atlasnacl.id
  rule_number    = 103
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22

}


resource "aws_network_acl_rule" "allow_inbound_nfs" {
  network_acl_id = aws_network_acl.atlasnacl.id
  rule_number    = 104
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 2049
  to_port        = 2049

}

resource "aws_network_acl_association" "publicnacl" {
  network_acl_id = aws_network_acl.atlasnacl.id
  subnet_id      = aws_subnet.publicsubnet1.id
}

resource "aws_network_acl_association" "privatenacl" {
  network_acl_id = aws_network_acl.atlasnacl.id
  subnet_id      = aws_subnet.privatesubnet1.id
}