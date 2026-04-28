

resource "aws_vpc" "aws03-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.prefix}vpc"
  }
}


resource "aws_subnet" "aws03-public-subnet" {
  count = length(var.public_subnet_cidr_blocks)
  vpc_id = aws_vpc.aws03-vpc.id
  cidr_block = var.public_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zone[count.index]
  tags = {
    Name = "${var.prefix}public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "aws03-private-subnet" {
  count = length(var.private_subnet_cidr_blocks)
  vpc_id = aws_vpc.aws03-vpc.id
  cidr_block = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zone[count.index]
  tags = {
    Name = "${var.prefix}private-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "aws03-igw" {
  vpc_id = aws_vpc.aws03-vpc.id
  tags = {
    Name = "${var.prefix}igw"
  }
}

resource "aws_eip" "aws03-nat-eip" {
  count = length(var.availability_zone)
  domain = "vpc"
  tags = {
    Name = "${var.prefix}nat-eip"
  }
}

resource "aws_nat_gateway" "aws03-nat-gw" {
  count = length(var.availability_zone)
  allocation_id = aws_eip.aws03-nat-eip[count.index].id
  subnet_id = aws_subnet.aws03-public-subnet[count.index].id
  depends_on = [aws_internet_gateway.aws03-igw]
  tags = {
    Name = "${var.prefix}nat-gw"
  }
}

resource "aws_route_table" "aws03-public-rt" {
  vpc_id = aws_vpc.aws03-vpc.id
  route  {
    
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws03-igw.id
  }

  tags = {
    Name = "${var.prefix}public-rt"
  }
}

resource "aws_route_table_association" "aws03-public-rt-association" {
  count = length(var.public_subnet_cidr_blocks)
  subnet_id = aws_subnet.aws03-public-subnet[count.index].id
  route_table_id = aws_route_table.aws03-public-rt.id
}

resource "aws_route_table" "aws03-private-rt" {
  count = length(var.private_subnet_cidr_blocks)
  vpc_id = aws_vpc.aws03-vpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.aws03-nat-gw[count.index].id
  }
  tags = {
    Name = "${var.prefix}private-rt-${count.index + 1}"
  }
}

resource "aws_route_table_association" "aws03-private-rt-association" {
  count = length(var.private_subnet_cidr_blocks)
  subnet_id = aws_subnet.aws03-private-subnet[count.index].id
  route_table_id = aws_route_table.aws03-private-rt[count.index].id
}

resource "aws_security_group" "aws03-sg" {
  name        = "${var.prefix}ssh-sg"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.aws03-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "aws03-http-sg" {
  name        = "${var.prefix}http-sg"
  description = "Allow HTTP and HTTPS access"
  vpc_id      = aws_vpc.aws03-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}