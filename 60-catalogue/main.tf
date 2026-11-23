resource "aws_instance" "catalogue" {
  ami           = local.ami_id
  instance_type = var.instance_type
  subnet_id = local.private_subnet_ids[0]
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


resource "aws_lb_target_group" "catalogue" {
  name        = "${var.project}-${var.env}-catalogue"
  target_type = "instance"
  port        = 8080
  protocol    = "TCP"
  vpc_id      = local.vpc_id
}


resource "aws_launch_template" "catalogue" {
  name = "${var.project}-${var.env}-catalogue"
  image_id = aws_ami_from_instance.catalogue.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]
  update_default_version = true 
  instance_initiated_shutdown_behavior = "terminate"
  tag_specifications {
    resource_type = "instance"

    tags = merge( {Name = "${var.project}-${var.env}-catalogue"} , local.common_tags)

  }

  tag_specifications {
    resource_type = "volume"

    tags = merge( {Name = "${var.project}-${var.env}-catalogue"} , local.common_tags)

  }

  tags = merge( {Name = "${var.project}-${var.env}-catalogue"} , local.common_tags)
}


resource "aws_autoscaling_group" "catalogue" {
  vpc_zone_identifier = local.private_subnet_ids
  desired_capacity   = 2
  max_size           = 10
  min_size           = 1
   instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }

  timeouts {
    delete = "15m"
  }

  launch_template {
    id      = aws_launch_template.catalogue.id
    version = aws_launch_template.catalogue.latest_version
  }
  target_group_arns = [ aws_lb_target_group.catalogue.arn ]

 

  dynamic "tag" {
     for_each = merge({Name = "${var.project}-${var.env}-catalogue"} , local.common_tags)

     content {
        key = tag.key
        value = tag.value 
        propagate_at_launch = true
     }
  }
}



resource "aws_autoscaling_policy" "catalogue" {
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  name                   = "${var.project}-${var.env}-catalogue"
  policy_type            = "TargetTrackingScaling"
  estimated_instance_warmup = 120 
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
      target_value = 70.0
    }
  }
  