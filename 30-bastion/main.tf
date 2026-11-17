resource "aws_instance" "bastion_vm" {
  ami           = local.ami_id
  instance_type = var.instance_type
  subnet_id = local.public_subnet_id
  vpc_security_group_ids = [ local.bastion_sg_id ]
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.bastionprofile.name
  tags = merge(var.tags, {Name = "${var.project}-${var.environment}-bastion"}, local.common_tags)
  user_data = file("bastion.sh")

  root_block_device {
     volume_size = 50
     volume_type = "gp3"
     
  }
}

resource "aws_iam_role" "bastionrole" {
    name = "${var.project}-${var.environment}-bastion-role"
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

resource "aws_iam_role_policy_attachment" "bastionpolicyattach" {
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    role = aws_iam_role.bastionrole.name
}

resource "aws_iam_instance_profile" "bastionprofile" {
    name = "${var.project}-${var.environment}-bastion-profile"
    role = aws_iam_role.bastionrole.name
}