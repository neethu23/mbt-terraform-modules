# ALB

# target group
resource "aws_lb_target_group" "demo-target-group" {
  name     = "${var.name}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.demo-vpc.id
}


# alb
resource "aws_lb" "demo-alb" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_80.id]
  subnets            = [aws_subnet.demo-subnet-public-2a.id, aws_subnet.demo-subnet-public-2b.id]


  tags = {
    Environment = "production"
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