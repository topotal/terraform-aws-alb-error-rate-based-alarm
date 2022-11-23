variable "sns_topic_arn" {
  type        = string
  description = "The arn of the SNS topic to use for alarm notifications"
}

variable "dimensions" {
  type        = map(string)
  description = "The dimensions to use for the metrics"
}

variable "alarm_name" {
  type        = string
  default     = "alb-error-rate-alarm"
  description = "The name of the alarm"
}

variable "comparison_operator" {
  type    = string
  default = "GreaterThanOrEqualToThreshold"
  validation {
    condition     = can(regex("GreaterThanOrEqualToThreshold|GreaterThanThreshold|LessThanThreshold|LessThanOrEqualToThreshold", var.comparison_operator))
    error_message = "The comparison operator must be one of GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, or LessThanOrEqualToThreshold"
  }
  description = "The comparison operator to use for the alarm"
}

variable "insufficient_data_actions" {
  type        = list(string)
  default     = []
  description = "The list of actions to take when the alarm is in insufficient data state"
}

variable "evaluation_periods" {
  type        = string
  default     = "1"
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "alarm_description" {
  type        = string
  default     = "This alarm monitors ALB/TargetGroup error rate with burn rate"
  description = "The description of the alarm"
}

variable "window" {
  type        = number
  default     = 60 * 60
  description = "The window to use for the metrics"
}

variable "slo" {
  type        = number
  default     = 99.9
  description = "The SLO to use for the alarm"
}

variable "burn_rate" {
  type        = number
  default     = 14.4
  description = "The burn rate to use for the alarm"
}
