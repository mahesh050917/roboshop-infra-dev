resource "aws_acm_certificate" "cert" {
  domain_name       = "*.${local.zone_name}"
  validation_method = "DNS"

  tags = merge({Name = local.zone_name},local.common_tags)
}

resource "aws_route53_record" "daws88s_record" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
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
  zone_id         = data.aws_route53_zone.selected.id
}