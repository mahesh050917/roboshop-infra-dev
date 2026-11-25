resource "aws_lb" "frontend_alb" {
  name               = "${var.project}-frontend-${var.env}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.frontend_alb_sg_id]
  subnets            = local.public_subnet_ids

  tags = merge(var.tags, {
      Name = "${var.project}-backend-${var.env}-alb"}, local.common_tags)
}


resource "aws_lb_listener" "backend_alb_listener" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "<h1> Hi I am from Frontend ALB </h1>"
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