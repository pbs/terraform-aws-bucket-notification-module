# PBS TF Bucket Notification Module

## Installation

### Using the Repo Source

Use this URL for the source of the module. See the usage examples below for more details.

```hcl
github.com/pbs/terraform-aws-bucket-notification-module?ref=0.0.5
```

### Alternative Installation Methods

More information can be found on these install methods and more in [the documentation here](./docs/general/install).

## Usage

Provisions a bucket notification trigger to invoke a Lambda function when an event is triggered on an S3 bucket.

By default, only runs when the event `s3:ObjectCreated:*"` is triggered. Update `events` to change this.

Optionally, use `filter_prefix` or `filter_suffix` to filter the objects that trigger the notification.

Integrate this module like so:

```hcl
module "bucket_notification" {
  source = "github.com/pbs/terraform-aws-bucket-notification-module?ref=0.0.5"

  # Required Parameters
  bucket     = module.s3.name
  lambda_arn = module.lambda.arn

  # Tagging Parameters
  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo

  # Optional Parameters
}
```

## Adding This Version of the Module

If this repo is added as a subtree, then the version of the module should be close to the version shown here:

`0.0.5`

Note, however that subtrees can be altered as desired within repositories.

Further documentation on usage can be found [here](./docs).

Below is automatically generated documentation on this Terraform module using [terraform-docs][terraform-docs]

---

[terraform-docs]: https://github.com/terraform-docs/terraform-docs

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lambda_permission.allow_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket_notification.bucket_notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | Bucket to attach notifications to | `string` | n/a | yes |
| <a name="input_lambda_arn"></a> [lambda\_arn](#input\_lambda\_arn) | ARN of the lambda to invoke | `string` | n/a | yes |
| <a name="input_events"></a> [events](#input\_events) | Event to notify on | `list(string)` | <pre>[<br>  "s3:ObjectCreated:*"<br>]</pre> | no |
| <a name="input_filter_prefix"></a> [filter\_prefix](#input\_filter\_prefix) | Prefix this notification should apply to | `string` | `null` | no |
| <a name="input_filter_suffix"></a> [filter\_suffix](#input\_filter\_suffix) | Suffix this notification should apply to | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | Bucket sending notifications |
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | ARN of the lambda function invoked by the notification |
