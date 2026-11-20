resource "aws_instance" "catalogue" {
  ami           = local.ami_id
  instance_type = var.instance_type
  subnet_id = local.private_subnet_ids
  vpc_security_group_ids = [ local.catalogue_sg_id ]
  tags = merge(var.tags, {Name = "${var.project}-${var.env}-catalogue"}, local.common_tags)

 
}

resource "terraform_data" "catalogue_bootstrap" {
   triggers_replace = [ aws_instance.catalogue.id ]

   connection {
      type = "ssh"
      user = "ec2-user"
      host = aws_instance.catalogue.private_ip
      password = "DevOps321"
   }

   provisioner "file" {
     source = "bootstrap.sh"
     destination = "/tmp/bootstrap.sh"
   }

   provisioner "remote-exec" {
      inline = [ 
            "chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh catalogue ${var.env}"
       ]
   }
}

resource "aws_ec2_instance_state" "catalogue" {
   instance_id = aws_instance.catalogue.id
   state = "stopped"

   depends_on = [ terraform_data.catalogue_bootstrap ]
}

resource "aws_ami_from_instance" "catalogue" {
    name = "${var.project}-${var.env}-catalogue"
    source_instance_id = aws_instance.catalogue.id

    depends_on = [ aws_ec2_instance_state.catalogue ]
}


