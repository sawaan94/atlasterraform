resource "aws_vpc" "atlas-vpx" {
  cidr_block           = "192.168.0.0/24"
  enable_dns_hostnames = true

  tags = {
    Name = "atlas-vpx"
  }
}

resource "aws_internet_gateway" "igw-1" {
  vpc_id = aws_vpc.atlas-vpx.id

  tags = {
    Name = "atlas-igw"
  }
}

resource "aws_nat_gateway" "ngw-1" {
  subnet_id         = aws_subnet.privatesubnet1.id
  connectivity_type = "private"

  tags = {
    Name = "atlas-ngw"
  }
}

resource "aws_subnet" "publicsubnet1" {
  vpc_id                  = aws_vpc.atlas-vpx.id
  cidr_block              = "192.168.0.0/25"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "tfpublicsubnet1"
  }

}

resource "aws_subnet" "privatesubnet1" {
  vpc_id            = aws_vpc.atlas-vpx.id
  cidr_block        = "192.168.0.128/25"
  availability_zone = "us-east-1a"
  tags = {
    Name = "tfprivatesubnet1"
  }
}

resource "aws_route_table" "publicroute" {
  vpc_id = aws_vpc.atlas-vpx.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-1.id
  }
}

resource "aws_route_table_association" "pubrta" {
  subnet_id      = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.publicroute.id

}

# resource "aws_network_acl_association" "nacl_pubsubnets" {
#   network_acl_id = aws_network_acl.atlasnacl.id
#   subnet_id      = aws_subnet.publicsubnet1.id

# }

# resource "aws_network_acl_association" "nacl_privsubnets" {
#   network_acl_id = aws_network_acl.atlasnacl.id
#   subnet_id      = aws_subnet.privatesubnet1.id

# }