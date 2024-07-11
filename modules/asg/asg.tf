# key pair

resource "aws_key_pair" "demo-key" {
  key_name   =  var.demo_key_name
  public_key = var.demo_key_value
}


# ASG

#create the lauch template
resource "aws_launch_template" "demo_launch_template" {
  name = "${var.name}_launch_template"
  image_id = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.demo-key.id
  vpc_security_group_ids = [var.sg_22_id, var.sg_80_id]
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.name}-instance-asg"
    }
  }

  user_data = filebase64("userdata.sh")
}

# asg
resource "aws_autoscaling_group" "demo-asg" {
  name_prefix = "${var.name}-asg-"
  vpc_zone_identifier = [var.subnet_public_2a_id, var.subnet_public_2b_id]
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size
  target_group_arns = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.demo_launch_template.id
    version = "$Latest"
  }
}

