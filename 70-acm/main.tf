resource "aws_acm_certificate" "cert" {
  domain_name       = local.zone_name
  validation_method = "DNS"

  tags = merge({Name=lcoal.zone_name},local.common_tags)
}

resource "aws_route53_record" "example" {
  for_each = {
    for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 2
  type            = each.value.type
  zone_id         = aws_route53_zone.example.zone_id
}