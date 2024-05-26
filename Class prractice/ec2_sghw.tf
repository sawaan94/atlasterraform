# data "template_file" "webserver_script" {
#   template = file("/home/ec2-user/terraform/webserver.sh")

# }

# resource "aws_instance" "vm1test" {
#   ami                    = "ami-0e001c9271cf7f3b9"
#   availability_zone      = "us-east-1c"
#   key_name               = "vskey"
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [aws_security_group.allow_req_traffic.id]
#   user_data              = data.template_file.webserver_script.rendered

#   root_block_device {
#     volume_size = 9
#   }

#   depends_on = [aws_security_group.allow_req_traffic]

#   tags = {
#     Name = "atlasec2tf"
#   }
# }

# resource "aws_security_group" "allow_req_traffic" {
#   name        = "all_http"
#   description = "allow inbound and outbound traffic"

#   tags = {
#     Name = "sgtest_tf"
#   }
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_http" {
#   security_group_id = aws_security_group.allow_req_traffic.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 80
#   ip_protocol       = "tcp"
#   to_port           = 80
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_https" {
#   security_group_id = aws_security_group.allow_req_traffic.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 443
#   ip_protocol       = "tcp"
#   to_port           = 443
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
#   security_group_id = aws_security_group.allow_req_traffic.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 22
#   ip_protocol       = "tcp"
#   to_port           = 22
# }

# resource "aws_vpc_security_group_egress_rule" "allow_all" {
#   security_group_id = aws_security_group.allow_req_traffic.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1"
# }

