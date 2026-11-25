locals {
  common_tags = {
    project     = var.project
    environment = var.env
    terraform   = true
  }
  zone_name = data.aws_route53_zone.daws88s_zone.name
  zone_id = data.aws_route53_zone.selected.id
}