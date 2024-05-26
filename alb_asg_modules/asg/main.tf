resource "aws_launch_template" "lt1test" {
  image_id               = "ami-0bb84b8ffd87024d8"
  instance_type          = "t2.micro"
  name                   = "mylaunchtemp"
  vpc_security_group_ids = [var.sgid]
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
  vpc_zone_identifier = [var.defsub1, var.defsub2]
  target_group_arns   = [var.tg1]
  depends_on          = [aws_launch_template.lt1test]

}