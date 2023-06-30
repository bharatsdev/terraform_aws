resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.network_vpc.id
  cidr_block              = "10.10.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"

  tags = {
    "Name" = "PublicSubnet_1"
    "VPC"  = "AWS_NETWORKING"
  }
}

resource "aws_route_table" "RT_PUBLIC" {
  vpc_id = aws_vpc.network_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.network_vpc_igw.id
  }
  tags = {
    "Name" = "RT_PUBLIC"
    "VPC"  = "AWS_NETWORKING"
  }
}
resource "aws_route_table_association" "subnet_route_table_association" {
  route_table_id = aws_route_table.RT_PUBLIC.id
  subnet_id      = aws_subnet.public_subnet.id
}


resource "aws_internet_gateway" "network_vpc_igw" {
  tags = {
    "Name" = "AWS_NETWORKING"
  }
}
resource "aws_internet_gateway_attachment" "igw_vpc_attachement" {
  internet_gateway_id = aws_internet_gateway.network_vpc_igw.id
  vpc_id              = aws_vpc.network_vpc.id
}


resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.network_vpc.id
  name   = "AWS_EC2_BASTAIN_SG"
  ingress {
    to_port     = "22"
    from_port   = "22"
    cidr_blocks = ["101.0.63.106/32"]
    protocol    = "tcp"
  }

  ingress {
    protocol    = "icmp"
    from_port   = -1
    to_port     = -1
    cidr_blocks = ["10.100.0.0/16"]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }

  tags = {
    "Name" = "SG_PublicSubnet"
    "VPC"  = "AWS_NETWORKING_EXAM_IGW"
  }
}
