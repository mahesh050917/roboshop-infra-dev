locals {
   ami_id = data.aws_ami.joindevops.id
   db_private_subnet_id = split(",",data.aws_ssm_parameter.db_private_subnet_ids.value)[0]
   mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
   redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
   mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
   zone_id = data.aws_route53_zone.daws88s_zone.id
   zone_name = data.aws_route53_zone.daws88s_zone.name
   common_tags = {
    project     = var.project
    environment = var.environment
    terraform   = true
  }
  roboshop_password = data.aws_ssm_parameter.roboshop_password.value
  mysql_role_name = join("-",[for name in ["${var.project}","${var.environment}","mysql","role"]:title(name)])
  mysql_policy_name = join(" ",[for name in ["${var.project}","${var.environment}","mysql","role"]:title(name)])
  mysql_instance_profile = join("-",[for name in ["${var.project}","${var.environment}","mysql","instance","profile"]:title(name)])
}