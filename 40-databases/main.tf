resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = var.instance_type
  subnet_id = local.db_private_subnet_id
  vpc_security_group_ids = [ local.mongodb_sg_id ]
  tags = merge(var.tags, {Name = "${var.project}-${var.environment}-${local.component[0]}"}, local.common_tags)
}

resource "aws_route53_record" "mongodb_record" {
  zone_id = local.zone_id
  name    = "${local.component[0]}-${var.environment}.${local.zone_name}"     #mongodb.daws88s.shop
  type    = "A"
  ttl     = 2
  records = [aws_instance.mongodb.private_ip]
}

resource "terraform_data" "bootstrap" {
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