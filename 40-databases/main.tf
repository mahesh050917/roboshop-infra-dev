resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = var.instance_type
  subnet_id = local.db_private_subnet_id
  vpc_security_group_ids = [ local.mongodb_sg_id ]
  tags = merge(var.tags, {Name = "${var.project}-${var.environment}-mongodb"}, local.common_tags)
}

resource "aws_route53_record" "mongodb_record" {
  zone_id = local.zone_id
  name    = "mongodb-${var.environment}.${local.zone_name}"     #mongodb-dev.daws88s.shop
  type    = "A"
  ttl     = 2
  records = [aws_instance.mongodb.private_ip]
}

resource "terraform_data" "mongodb_bootstrap" {
   triggers_replace = [ aws_instance.mongodb.id]

   connection {
      type = "ssh"
      user = "ec2-user"
      host = aws_instance.mongodb.private_ip
      password = "DevOps321"
   }

   provisioner "file" {
     source = "bootstrap.sh"
     destination = "/tmp/bootstrap.sh"
   }

   provisioner "remote-exec" {
      inline = [ 
            "chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh mongodb"
       ]
   }
}


resource "aws_instance" "redis" {
  ami           = local.ami_id
  instance_type = var.instance_type
  subnet_id = local.db_private_subnet_id
  vpc_security_group_ids = [ local.redis_sg_id ]
  tags = merge(var.tags, {Name = "${var.project}-${var.environment}-redis"}, local.common_tags)
}

resource "aws_route53_record" "redis_record" {
  zone_id = local.zone_id
  name    = "redis-${var.environment}.${local.zone_name}"     #redis-dev.daws88s.shop
  type    = "A"
  ttl     = 2
  records = [aws_instance.redis.private_ip]
}

resource "terraform_data" "redis_bootstrap" {
   triggers_replace = [ aws_instance.redis.id]

   connection {
      type = "ssh"
      user = "ec2-user"
      host = aws_instance.redis.private_ip
      password = "DevOps321"
   }

   provisioner "file" {
     source = "bootstrap.sh"
     destination = "/tmp/bootstrap.sh"
   }

   provisioner "remote-exec" {
      inline = [ 
            "chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh redis"
       ]
   }
}


resource "aws_instance" "mysql" {
  ami           = local.ami_id
  instance_type = var.instance_type
  subnet_id = local.db_private_subnet_id
  vpc_security_group_ids = [ local.mysql_sg_id ]
  iam_instance_profile = aws_iam_instance_profile.mysqlinstanceprofile.name
  tags = merge(var.tags, {Name = "${var.project}-${var.environment}-mysql"}, local.common_tags)
}

resource "aws_route53_record" "mysql_record" {
  zone_id = local.zone_id
  name    = "mysql-${var.environment}.${local.zone_name}"     #mysql-dev.daws88s.shop
  type    = "A"
  ttl     = 2
  records = [aws_instance.mysql.private_ip]
}

resource "terraform_data" "mysql_bootstrap" {
   triggers_replace = [ aws_instance.mysql.id]

   connection {
      type = "ssh"
      user = "ec2-user"
      host = aws_instance.mysql.private_ip
      password = local.roboshop_password
   }

   provisioner "file" {
     source = "bootstrap.sh"
     destination = "/tmp/bootstrap.sh"
   }

   provisioner "remote-exec" {
      inline = [ 
            "chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh mysql  ${var.environment}"
       ]
   }
}