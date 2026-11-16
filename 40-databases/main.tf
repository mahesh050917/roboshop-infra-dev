resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = var.instance_type
  subnet_id = local.db_private_subnet_id
  vpc_security_group_ids = [ local.mongodb_sg_id ]
  tags = merge(var.tags, {Name = "${var.project}-${var.environment}-${local.component}"}, local.common_tags)
}

resource "aws_route53_record" "mongodb_record" {
  zone_id = local.zone_id
  name    = "{local.component}.${local.zone_name}"     #mongodb.daws88s.shop
  type    = "A"
  ttl     = 2
  records = [aws_instance.mongodb.private_ip]
}