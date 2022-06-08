# PBS TF bucket notification module

## Installation

### Using the Repo Source

Use this URL for the source of the module. See the usage examples below for more details.

```hcl
github.com/pbs/terraform-aws-bucket-notification-module?ref=x.y.z
```

### Alternative Installation Methods

More information can be found on these install methods and more in [the documentation here](./docs/general/install).

## Usage

Provisions a bucket notification trigger to invoke a Lambda function when an event is triggered on an S3 bucket.

By default, only runs when the event `s3:ObjectCreated:*"` is triggered. Update `events` to change this.

Optionally, use `filter_prefix` or `filter_suffix` to filter the objects that trigger the notification.

Integrate this module like so:

```hcl
module "bucket-notification" {
  source = "github.com/pbs/terraform-aws-bucket-notification-module?ref=x.y.z"

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

`x.y.z`

Note, however that subtrees can be altered as desired within repositories.

Further documentation on usage can be found [here](./docs).

Below is automatically generated documentation on this Terraform module using [terraform-docs][terraform-docs]

---

[terraform-docs]: https://github.com/terraform-docs/terraform-docs
