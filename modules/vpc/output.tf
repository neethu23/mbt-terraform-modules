output "vpc_id"{
    value = aws_vpc.demo-vpc.id
}

output "subnet_public_2a_id"{
    value = aws_subnet.demo-subnet-public-2a.id
}

output "subnet_public_2b_id"{
    value = aws_subnet.demo-subnet-public-2b.id
}
