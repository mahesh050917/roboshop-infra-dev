resource "aws_ssm_parameter" "acm_cert_arn" {
  name        = "/${var.project}/acm_cert_arn"
  value = aws_acm_certificate.cert.arn
  type = "String"
}