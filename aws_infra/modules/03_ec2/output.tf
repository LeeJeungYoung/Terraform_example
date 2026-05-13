
output "instance_id" {
  value = aws_instance.aws03_instance.id
}

output "instance_public_ip" {
  value = aws_instance.aws03_instance.public_ip
}

output "instance_private_ip" {
  value = aws_instance.aws03_instance.private_ip
}

output "ami_id" {
  value = aws_ami_from_instance.aws03_ami.id
}

output "ami_name" {
  value = aws_ami_from_instance.aws03_ami.name
}