resource "aws_ssm_parameter" "sg_id" {
  count = length(var.sg_name)
  name        = "/${var.project}/${var.environment}/${var.sg_name[count.index]}_sg_id"
  value = module.sg[count.index].sg_id
  type = "String"

}