#create Security Group for ASG & ALB

resource "aws_security_group" "allow_22" {
  name        = "allow_22"
  description = "Allow TLS inbound traffic to port 22"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_22"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_22" {
  security_group_id = aws_security_group.allow_22.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound" {
  security_group_id = aws_security_group.allow_22.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_traffic_ipv6" {
  security_group_id = aws_security_group.allow_22.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "allow_80" {
  name        = "allow_80"
  description = "Allow TLS inbound traffic to port 80"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_80"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_80" {
  security_group_id = aws_security_group.allow_80.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_1" {
  security_group_id = aws_security_group.allow_80.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_traffic_ipv6_1" {
  security_group_id = aws_security_group.allow_80.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

