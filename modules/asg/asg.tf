# key pair

resource "aws_key_pair" "demo-key" {
  key_name   = "demo-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCnWfXdWECxjE2in1OnLRPMT2CHRk/Z1LQlrPTMl3EdoxeowRwA3jlmVEWjkg1+Q0DShqMUNR2uFP4J64Il2R6/cJk8cDCIXmAoiI0f6klxAM3XkwRirhr4Qd8N0Ujqc+NxABUo7CK6lEuQ9UIFBXeaWl9VzSLPoxFIU1DY8xnjAjqAFrIkTmZ6aG+827h5CiB9NwoV345C7d3LWlQPiur2NtkT0aglwSxzIeyIEx3p9C/msYTvBijBojxnbpeUfGVi8q4B1BbUZHCRWynNvkMDNH01UlUJFUuxAMk3nF/ClP3VqBx7fHWr6d9MzhCWv2jAq9/lyRMpRVh3euNWwKrNl1Ld5XsT6nB8fHCbjB++0mFUNoZN2OrbJNvNJBe2TzS8/YO067gq5TdUrxPGqB42GTxKoSNEiDmAcZD6ogPhj3pr3u5V6cpb0/0yd7L2xTd8VYBx5jFp9deHrCY+GMqcp5Y/ln4JnARyCdWeRbvTvSI5esoYhokMkQ/ok77llHM= ssankar1@ussd-ofcmc6821.lan"
}


# ASG

#create the lauch template
resource "aws_launch_template" "demo_launch_template" {
  name = "${var.name}_launch_template"
  image_id = "ami-0862be96e41dcbf74"
  instance_type = var.instance_type
  key_name = aws_key_pair.demo-key.id
  vpc_security_group_ids = [aws_security_group.allow_22.id, aws_security_group.allow_80.id]
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
  vpc_zone_identifier = [aws_subnet.demo-subnet-public-2a.id, aws_subnet.demo-subnet-public-2b.id]
  desired_capacity   = 2
  max_size           = 5
  min_size           = 2
  target_group_arns = [aws_lb_target_group.demo-target-group.arn]

  launch_template {
    id      = aws_launch_template.demo_launch_template.id
    version = "$Latest"
  }
}

