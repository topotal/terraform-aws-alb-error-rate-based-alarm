output "cloudwatch_alarm" {
  value       = aws_cloudwatch_metric_alarm.alarm
  description = "The created CloudWatch alarm"
}
