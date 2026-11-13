resource "aws_ssm_parameter" "vpc_id" {
  name        = "/${var.project}/${var.environment}/vpc_id"
  value = module.vpc.vpc_id
  type = "String"

}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name        = "/${var.project}/${var.environment}/public_subnet_ids"
  value = join(",", module.vpc.public_subnet_ids)
  type = "StringList"

}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name        = "/${var.project}/${var.environment}/private_subnet_ids"
  value = join(",", module.vpc.private_subnet_ids)
  type = "StringList"

}

resource "aws_ssm_parameter" "db_private_subnet_ids" {
  name        = "/${var.project}/${var.environment}/db_private_subnet_ids"
  value = join(",", module.vpc.db_private_subnet_ids)
  type = "StringList"

}