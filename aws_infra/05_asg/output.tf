
output "launch_template_id" {
  value = aws_launch_template.aws03_was_lt.id
}

output "launch_template_latest_version" {
  value = aws_launch_template.aws03_was_lt.latest_version
}

output "asg_name" {
  value = aws_autoscaling_group.aws03_was_asg.name
}

output "asg_arn" {
  value = aws_autoscaling_group.aws03_was_asg.arn
}

output "asg_min_size" {
  value = aws_autoscaling_group.aws03_was_asg.min_size
}

output "asg_max_size" {
  value = aws_autoscaling_group.aws03_was_asg.max_size
}

output "asg_desired_capacity" {
  value = aws_autoscaling_group.aws03_was_asg.desired_capacity
}