locals {
   ami_id = data.aws_ami.joindevops.id
   db_private_subnet_id = split(",",data.aws_ssm_parameter.db_private_subnet_ids.value)[0]
   mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
   redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
   mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
   zone_id = data.aws_route53_zone.daws88s_zone.id
   zone_name = data.aws_route53_zone.daws88s_zone.name
   backend_alb_sg_id = data.aws_ssm_parameter.backend_alb_sg_id.value 
   frontend_alb_sg_id = data.aws_ssm_parameter.frontend_alb_sg_id.value 
   private_subnet_ids = split(",",data.aws_ssm_parameter.private_subnet_ids.value)
   common_tags = {
    project     = var.project
    environment = var.env
    terraform   = true
  }
}