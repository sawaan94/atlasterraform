resource "aws_instance" "vm1" {
  ami                    = "ami-0bb84b8ffd87024d8"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [var.sgid]
  subnet_id              = var.subnet
  user_data              = <<-EOF
        #!/bin/bash
        sudo yum update
        sudo yum install httpd -y
        sudo systemctl start httpd
        sudo systemctl enable httpd
        echo "Hi this is $HOSTNAME" >> /var/www/html/index.html
        EOF


  tags = {
    Name = "vm1"
  }
}