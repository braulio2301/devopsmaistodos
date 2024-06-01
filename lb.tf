variable "vpc_id" {}

data "aws_vpc" "maistodos_vpc" {
  id = var.vpc_id
}

resource "aws_security_group" "alb_security_group" {
  name_prefix = "alb-sg"
  vpc_id            = data.aws_vpc.maistodos_vpc.id


  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_lb" "alb" {
  name               = "alb-maistodos"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb_security_group.id
  ]

  subnets = aws_subnet.private.*.id
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.target_group.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "target_group" {
  name_prefix      = "my-target-group"
  port             = 3000
  protocol         = "HTTP"
  vpc_id            = data.aws_vpc.maistodos_vpc.id
  target_type      = "ip"
  health_check {
    interval            = 30
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
    path                = "/"
    matcher             = "200-399"
  }
}