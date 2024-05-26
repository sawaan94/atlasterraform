data "aws_vpc" "defvpc" {
  default = true
}

data "aws_subnet" "defsubnet1" {
  id = "subnet-0d0dd612c916e9132" #1b 
}
data "aws_subnet" "defsubnet2" {
  id = "subnet-06fcef8296be557f2" #1a
}

// security group
resource "aws_security_group" "albsg" {
  name        = "albsg"
  description = "sg for alb and webservers"
  vpc_id      = data.aws_vpc.defvpc.id
  ingress {
    description = "inbound rules for ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "inbound rules for http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "inbound rules for https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "outbound traffic for all"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

//load balancer
resource "aws_alb" "alb1" {
  internal           = false
  load_balancer_type = "application"
  name               = "atlasalb"
  security_groups    = [aws_security_group.albsg.id]
  subnets            = [data.aws_subnet.defsubnet1.id, data.aws_subnet.defsubnet2.id]

  depends_on = [aws_alb.alb1]
}

resource "aws_lb_target_group" "tg1" {
  load_balancing_algorithm_type = "round_robin"
  port                          = 80
  name                          = "tgtest1"
  slow_start                    = 120
  target_type                   = "instance"
  protocol = "HTTP"
  vpc_id                        = data.aws_vpc.defvpc.id
  depends_on                    = [aws_alb.alb1]

}

resource "aws_lb_listener" "listener1test" {
  load_balancer_arn = aws_alb.alb1.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg1.arn
  }
  port       = 80
  protocol   = "HTTP"
  depends_on = [aws_alb.alb1, aws_lb_target_group.tg1]

}

resource "aws_launch_template" "lt1test" {
  image_id               = "ami-0bb84b8ffd87024d8"
  instance_type          = "t2.micro"
  name                   = "mylaunchtemp"
  vpc_security_group_ids = [aws_security_group.albsg.id]
  user_data = base64encode(
    <<-EOF
        #!/bin/bash
        sudo yum update -y
        sudo yum install httpd* -y
        sudo systemctl start httpd
        sudo systemctl enable httpd
        echo "Hi I am $HOSTNAME" >> /var/www/html/index.html
        EOF
  )
}

resource "aws_autoscaling_group" "ASGtest1" {
  name             = "ASGtest1"
  max_size         = 3
  min_size         = 1
  desired_capacity = 2
  launch_template {
    id      = aws_launch_template.lt1test.id
    version = aws_launch_template.lt1test.latest_version
  }
  health_check_type   = "ELB"
  vpc_zone_identifier = [data.aws_subnet.defsubnet1.id, data.aws_subnet.defsubnet2.id]
  target_group_arns   = [aws_lb_target_group.tg1.arn]
  depends_on          = [aws_launch_template.lt1test, aws_lb_target_group.tg1]

}