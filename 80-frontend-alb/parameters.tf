resource "aws_ssm_parameter" "frontend_listener_arn" {
  name        = "/${var.project}/${var.env}/frontend_listener_arn"
  value = aws_lb_listener.frontend_alb_listener.arn
  type = "String"
}