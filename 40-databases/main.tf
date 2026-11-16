resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = var.instance_type
  subnet_id = local.db_private_subnet_id
  vpc_security_group_ids = [ local.mongodb_sg_id ]
  tags = merge(var.tags, {Name = "${var.project}-${var.environment}-mongodb"}, local.common_tags)
}

