resource "aws_launch_template" "lt1" {
  name          = "launch-template-1"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key
  user_data     = base64encode (<<-EOF
    #!/bin/bash
    apt update 
    apt install apache2 -y
    systemctl start apache2
    systemctl enable apache2
    echo "this is my $HOSTNAME" >> /var/www/html/index.html
    EOF
  )

  placement {
    availability_zone = var.az
  }
  vpc_security_group_ids = [aws_security_group.atlas-sg.id] #if we don't add this, it would select the default vpc
  # we didn't add the vpc_id so we will select the default
}

#autoscaling group resource block
resource "aws_autoscaling_group" "asg1" {
  name                      = "test-asg1"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 60
  desired_capacity          = 2
  vpc_zone_identifier       = [aws_subnet.privatesubnet1.id]
  launch_template {
    id = aws_launch_template.lt1.id
    version = aws_launch_template.lt1.latest_version
  }

  depends_on = [aws_launch_template.lt1]

}