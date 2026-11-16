locals {
   ami_id = data.aws_ami.joindevops.id
   db_private_subnet_id = split(",",data.aws_ssm_parameter.db_private_subnet_ids.value)[0]
   mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
   zone_id = data.aws_route53_zone.daws88s_zone.id
   zone_name = data.aws_route53_zone.daws88s_zone.name
   common_tags = {
    project     = var.project
    environment = var.environment
    terraform   = true
  }
  component = ["mongodb"]
}