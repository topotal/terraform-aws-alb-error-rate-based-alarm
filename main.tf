locals {
  error_budget = (100 - var.slo) / 100
  threshold    = local.error_budget * var.burn_rate
}

data "aws_sns_topic" "sns" {
  name = var.sns_topic_name
}

resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name                = var.alarm_name
  comparison_operator       = var.comparison_operator
  evaluation_periods        = var.evaluation_periods
  threshold                 = local.threshold
  alarm_description         = var.alarm_description
  insufficient_data_actions = var.insufficient_data_actions

  alarm_actions = [var.sns_topic_arn]
  ok_actions    = [var.sns_topic_arn]

  metric_query {
    id          = "erate"
    expression  = "target5xx / (target2xx + target4xx + target5xx)"
    label       = "error_rate"
    return_data = "true"
  }

  metric_query {
    id = "target2xx"

    metric {
      metric_name = "HTTPCode_Target_2XX_Count"
      namespace   = "AWS/ApplicationELB"
      period      = var.window
      stat        = "Sum"
      unit        = "Count"

      dimensions = var.dimensions
    }
  }

  metric_query {
    id = "target4xx"

    metric {
      metric_name = "HTTPCode_Target_4XX_Count"
      namespace   = "AWS/ApplicationELB"
      period      = var.window
      stat        = "Sum"
      unit        = "Count"

      dimensions = var.dimensions
    }
  }

  metric_query {
    id = "target5xx"

    metric {
      metric_name = "HTTPCode_Target_5XX_Count"
      namespace   = "AWS/ApplicationELB"
      period      = var.window
      stat        = "Sum"
      unit        = "Count"

      dimensions = var.dimensions
    }
  }

}
