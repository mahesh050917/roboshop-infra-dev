module "vpc" {
   source = "git::https://github.com/maheshg-devops88/terraform-aws-vpc.git?ref=main"
   cidr_block = "10.0.0.0/16"
   environment = "dev"
   project = "roboshop"
   is_peering_required = true
}