locals {
   ami_id = data.aws_ami.joindevops.id
   public_subnet_id = split(",",data.aws_ssm_parameter.public_subnet_ids.value)[0]
   zone_id = data.aws_route53_zone.daws88s_zone.id
   zone_name = data.aws_route53_zone.daws88s_zone.name
   backend_alb_sg_id = data.aws_ssm_parameter.backend_alb_sg_id.value 
   frontend_alb_sg_id = data.aws_ssm_parameter.frontend_alb_sg_id.value 
   public_subnet_ids = split(",",data.aws_ssm_parameter.private_subnet_ids.value)
   common_tags = {
    project     = var.project
    environment = var.env
    terraform   = true
  }
}