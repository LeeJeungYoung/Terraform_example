

#시작 템플릿

resource "aws_launch_template" "aws03_launch_template" {
  name_prefix   = "${var.prefix}-launch-template-"
  image_id      = data.aws_ami.aws03_instance_ami.id
  instance_type = var.instance_type
  key_name        = var.key_name
  
  iam_instance_profile {
    name = data.aws_iam_instance_profile.aws03_ec2_instance_profile.name
  }

  network_interfaces {
    associate_public_ip_address = "false"
    security_groups             = [
      data.aws_security_group.aws03_ssh_sg.id
      data.aws_security_group.aws03_http_sg.id
    ]
      
    subnet_id = element(data.aws_subnets.aws03_private_subnet.ids, count.index)
}

tag_specifications {
    resource_type = "instance"

    tags = {
     Name = "${var.prefix}-instance"
     
    }
  }
  
  lifecycle {
    create_before_destroy = true
  }
}






# 오토 스케일링 그룹








# 대상 그룹 연결