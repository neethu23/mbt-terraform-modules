# ALB

# target group
resource "aws_lb_target_group" "demo-target-group" {
  name     = "${var.name}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}


# alb
resource "aws_lb" "demo-alb" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_80_id]
  subnets            = [var.subnet_public_2a_id, var.subnet_public_2b_id]


  tags = {
    Environment = "var.Environment"
  }
}

# listener
resource "aws_lb_listener" "demo_listener" {
  load_balancer_arn = aws_lb.demo-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo-target-group.arn
  }
}