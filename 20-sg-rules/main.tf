resource "aws_security_group_rule" "egress_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}


resource "aws_security_group_rule" "bastion_internet" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [local.my_ip/32]
  security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}


