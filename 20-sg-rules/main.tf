resource "aws_security_group_rule" "bastion_internet" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${local.my_ip}/32"]
  security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}


resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = data.aws_ssm_parameter.mongodb_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}

resource "aws_security_group_rule" "mongodb_catalogue" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  security_group_id = data.aws_ssm_parameter.catalogue_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.mongodb_sg_id.value
}

resource "aws_security_group_rule" "redis_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = data.aws_ssm_parameter.redis_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}

resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = data.aws_ssm_parameter.mysql_sg_id.value
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}