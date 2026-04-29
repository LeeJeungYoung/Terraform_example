

data "aws_vpc" "aws03_vpc" {
  filter {
    name   = "tag:Name"
    values = ["aws03-vpc"]
  }  
  
}

data "aws_subnets" "aws03_public_subnets" {
  filter {
    name   = "tag:Name"
    values = ["${var.prefix}-public-subnet-*"]
  }  
  
}

data "aws_security_group" "aws03_http_sg" {
  filter {
    name   = "tag:Name"
    values = ["${var.prefix}-http-sg"]
  }  
  
}
