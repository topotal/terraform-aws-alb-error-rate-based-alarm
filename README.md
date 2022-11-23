# terraform-aws-alb-error-rate-based-alarm

Terraform module for creating AWS ALB Error rate based CloudWatch Alarm.

https://registry.terraform.io/modules/topotal/alb-error-rate-based-alarm/aws/latest

## Usage

Copy and paste into your Terraform configuration, insert the variables, and run terraform init:

```terraform
module "alb-error-rate-based-alarm" {
  source  = "topotal/alb-error-rate-based-alarm/aws"
  version = "0.1.0"

  sns_topic_arn  = "YOUR_SNS_TOPIC_ARN_FOR_NOTIFICATION"
  dimensions     = {
    LoadBalancer = "app/YOUR_LOAD_BALANCER_NAME/YOUR_LOAD_BALANCER_ID"
  }
}
```

or you can speficy `TargetGroup` to dimensions if you want to monitor only for TargetGroup:

```terraform
module "alb-error-rate-based-alarm" {
  source  = "topotal/alb-error-rate-based-alarm/aws"
  version = "0.1.0"

  sns_topic_arn  = "YOUR_SNS_TOPIC_ARN_FOR_NOTIFICATION"
  dimensions     = {
    LoadBalancer = "app/YOUR_LOAD_BALANCER_NAME/YOUR_LOAD_BALANCER_ID"
    TargetGroup  = "targetgroup/YOUR_TARGET_GROUP_NAME/YOUR_TARGET_GROUP_ID"
  }
}
```

The default threshold is 99.9% SLO and 14.4 Burn Rate with 1 hour time window (SLO budget consumption 2%).

This module can also specify slo, burn_rate and window like below:

```terraform
module "alb-error-rate-based-alarm" {
  source  = "topotal/alb-error-rate-based-alarm/aws"
  version = "0.1.0"

  sns_topic_arn  = "YOUR_SNS_TOPIC_ARN_FOR_NOTIFICATION"
  dimensions     = {
    LoadBalancer = "app/YOUR_LOAD_BALANCER_NAME/YOUR_LOAD_BALANCER_ID"
  }

  slo       = 99.99
  burn_rate = 6
  period    = 60 * 60 * 6
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.74.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.74.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_sns_topic.sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sns_topic) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_description"></a> [alarm\_description](#input\_alarm\_description) | The description of the alarm | `string` | `"This alarm monitors ALB/TargetGroup error rate with burn rate"` | no |
| <a name="input_alarm_name"></a> [alarm\_name](#input\_alarm\_name) | The name of the alarm | `string` | `"alb-error-rate-alarm"` | no |
| <a name="input_burn_rate"></a> [burn\_rate](#input\_burn\_rate) | The burn rate to use for the alarm | `number` | `14.4` | no |
| <a name="input_comparison_operator"></a> [comparison\_operator](#input\_comparison\_operator) | The comparison operator to use for the alarm | `string` | `"GreaterThanOrEqualToThreshold"` | no |
| <a name="input_dimensions"></a> [dimensions](#input\_dimensions) | The dimensions to use for the metrics | `map(string)` | n/a | yes |
| <a name="input_evaluation_periods"></a> [evaluation\_periods](#input\_evaluation\_periods) | The number of periods over which data is compared to the specified threshold | `string` | `"1"` | no |
| <a name="input_insufficient_data_actions"></a> [insufficient\_data\_actions](#input\_insufficient\_data\_actions) | The list of actions to take when the alarm is in insufficient data state | `list(string)` | `[]` | no |
| <a name="input_slo"></a> [slo](#input\_slo) | The SLO to use for the alarm | `number` | `99.9` | no |
| <a name="input_sns_topic_arn"></a> [sns\_topic\_arn](#input\_sns\_topic\_arn) | The arn of the SNS topic to use for alarm notifications | `string` | n/a | yes |
| <a name="input_window"></a> [window](#input\_window) | The window to use for the metrics | `number` | `3600` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_alarm"></a> [cloudwatch\_alarm](#output\_cloudwatch\_alarm) | The created CloudWatch alarm |
<!-- END_TF_DOCS -->
