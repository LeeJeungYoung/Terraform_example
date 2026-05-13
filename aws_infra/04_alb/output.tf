

output "alb_arn" {
  value = aws_lb.aws03_alb.arn
}

output "alb_dns_name" {
  value = aws_lb.aws03_alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.aws03_alb.zone_id
}

output "alb_listener_arn" {
  value = aws_lb_listener.aws03_alb_listener.arn
}

output "was_target_group_arn" {
  value = aws_lb_target_group.aws03_alb_was_group.arn
}

output "jenkins_target_group_arn" {
  value = aws_lb_target_group.aws03_alb_jenkins_group.arn
}

output "was_listener_rule_arn" {
  value = aws_lb_listener_rule.aws03_alb_was_rule.arn
}

output "jenkins_listener_rule_arn" {
  value = aws_lb_listener_rule.aws03_alb_jenkins_rule.arn
}