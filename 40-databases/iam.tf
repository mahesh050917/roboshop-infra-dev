resource "aws_iam_role" "mysqlrole" {
    name = local.mysql_role_name  #Roboshop-Dev-Mysql-Role
    tags = merge(var.tags,local.common_tags)
    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

}


resource "aws_iam_policy" "mysqlpolicy" {
   name = local.mysql_policy_name
   policy = file("iam_sql_policy.json")
}


resource "aws_iam_role_policy_attachment" "mysqlroleattach" {
    role = aws_iam_role.mysqlrole.name
    policy_arn = aws_iam_policy.mysqlpolicy.arn
}

resource "aws_iam_instance_profile" "mysqlinstanceprofile" {
    name = local.mysql_instance_profile
    role = aws_iam_role_policy_attachment.mysqlroleattach.name
}