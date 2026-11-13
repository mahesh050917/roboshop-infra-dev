module "sg" {
    source = "git::https://github.com/mahesh050917/terraform-aws-sg.git?ref=main"
    environment = var.environment
    project = var.project
}