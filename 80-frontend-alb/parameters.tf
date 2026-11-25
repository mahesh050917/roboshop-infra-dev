resource "aws_ssm_parameter" "backend_listener_arn" {
  name        = "/${var.project}/${var.env}/backend_listener_arn"
  value = aws_lb_listener.backend_alb_listener.arn
  type = "String"
}

