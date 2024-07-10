#creating the vpc

resource "aws_vpc" "demo-vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "${var.name}-vpc" 
  }
}

 #creating the subnets

resource "aws_subnet" "demo-subnet-public-2a" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = var.cidr_block_subnet_1
  availability_zone       = var.az_1
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-subnet-public-2a"
  }
}

resource "aws_subnet" "demo-subnet-public-2b" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = var.cidr_block_subnet_2
  availability_zone       = var.az_2
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-subnet-public-2b"
  }
}

resource "aws_subnet" "demo-subnet-private-2a" {
  vpc_id            = aws_vpc.demo-vpc.id
  cidr_block        = var.cidr_block_subnet_3
  availability_zone = var.az_1

  tags = {
    Name = "${var.name}-subnet-private-2a"
  }
}

resource "aws_subnet" "demo-subnet-private-2b" {
  vpc_id            = aws_vpc.demo-vpc.id
  cidr_block        = var.cidr_block_subnet_4
  availability_zone = var.az_2

  tags = {
    Name = "${var.name}-subnet-private-2b"
  }
}

#create IGW

resource "aws_internet_gateway" "demo-IGW" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "${var.name}-internet-GW"
  }
}

#create RT

resource "aws_route_table" "demo-public-RT" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-IGW.id
  }

  tags = {
    Name = "${var.name}-public-RT"
  }
}


resource "aws_route_table" "demo-private-RT" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "${var.name}-private-RT"
  }
}

resource "aws_route_table_association" "RT_asso_subnet_1_public" {
  subnet_id      = aws_subnet.demo-subnet-public-2a.id
  route_table_id = aws_route_table.demo-public-RT.id
}

resource "aws_route_table_association" "RT_asso_subnet_2_public" {
  subnet_id      = aws_subnet.demo-subnet-public-2b.id
  route_table_id = aws_route_table.demo-public-RT.id
}

resource "aws_route_table_association" "RT_asso_subnet_3_private" {
  subnet_id      = aws_subnet.demo-subnet-private-2a.id
  route_table_id = aws_route_table.demo-private-RT.id
}
resource "aws_route_table_association" "RT_asso_subnet_4_private" {
  subnet_id      = aws_subnet.demo-subnet-private-2b.id
  route_table_id = aws_route_table.demo-private-RT.id
}