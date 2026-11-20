resource "aws_lb" "backend_alb" {
  name               = "${var.project}-backend-${var.env}-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.backend_alb_sg_id]
  subnets            = local.private_subnet_ids

  tags = merge(var.tags, {
      Name = "${var.project}-backend-${var.env}-alb"}, local.common_tags)
}


resource "aws_lb_listener" "backend_alb_listener" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "<h1> Hi I am from Backend ALB </h1>"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "backend_alb_record" {
  zone_id = local.zone_id
  name    = "*.backend-alb-${var.env}.${local.zone_name}"   # *.backend-alb-dev.daws88s.shop
  type = "A"
  alias {
     name =   aws_lb.backend_alb.dns_name
     evaluate_target_health = true
     zone_id = aws_lb.backend_alb.zone_id
  }
}