//load balancer
resource "aws_alb" "alb1" {
  internal           = false
  load_balancer_type = "application"
  name               = "atlasalb"
  security_groups    = [var.sgid]
  subnets            = [var.defsub1, var.defsub2]

  depends_on = [aws_alb.alb1]
}

resource "aws_lb_target_group" "tg1" {
  load_balancing_algorithm_type = "round_robin"
  port                          = 80
  name                          = "tgtest1"
  slow_start                    = 120
  target_type                   = "instance"
  protocol = "HTTP"
  vpc_id                        = var.vpcid
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