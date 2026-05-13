

#output.tf
output "vpc_id" {
  value = aws_vpc.aws03_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.aws03_public_subnet[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.aws03_private_subnet[*].id
}

output "ssh_sg_id" {
  value = aws_security_group.aws03_sg.id
}

output "http_sg_id" {
  value = aws_security_group.aws03_http_sg.id
}