

data "aws_route53_zone" "daws88s_zone" {
  name         = "daws88s.shop"
  private_zone = false
}

data "aws_route53_zone" "selected" {
  name         = "daws88s.shop"
  private_zone = false # Set to true for private hosted zones
}