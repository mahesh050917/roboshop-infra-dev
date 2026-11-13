module "sg" {
    count = length(var.sg_name)
    source = "git::https://github.com/mahesh050917/terraform-aws-sg.git?ref=main"
    environment = var.environment
    project = var.project
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = replace(var.sg_name[count.index] ,"_" ,"-")
}