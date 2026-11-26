module "components" {
   source = "git::https://github.com/mahesh050917/terraform-roboshop-components.git?ref=main"
   for_each = var.components
   components = each.key
   rule_priority = each.value.rule_priority
   health_check_port = 8080

}