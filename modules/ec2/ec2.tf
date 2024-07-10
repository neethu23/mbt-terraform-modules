resource "aws_instance" "demo-instance-2" {
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.micro"
#   subnet_id = aws_subnet.demo-subnet-1b.id
#   key_name = aws_key_pair.demo-key.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.allow_22.id, aws_security_group.allow_80.id]
#   user_data = filebase64("userdata.sh")

  tags = {
    Name = "demo-machine2"
  }
}