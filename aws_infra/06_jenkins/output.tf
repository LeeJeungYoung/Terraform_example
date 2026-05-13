

output "jenkins_instance_id" {
  value = aws_instance.aws03_jenkins_server.id
}

output "jenkins_private_ip" {
  value = aws_instance.aws03_jenkins_server.private_ip
}

output "jenkins_instance_profile" {
  value = aws_instance.aws03_jenkins_server.iam_instance_profile
}

output "jenkins_target_group_attachment_id" {
  value = aws_lb_target_group_attachment.aws03_jenkins_attach.id
}