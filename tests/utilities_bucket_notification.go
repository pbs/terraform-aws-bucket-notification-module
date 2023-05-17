package test

import (
	"fmt"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func testBucketNotificationModule(t *testing.T, variant string) {
	t.Parallel()

	terraformDir := fmt.Sprintf("../examples/%s", variant)

	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		LockTimeout:  "5m",
	}

	defer terraform.Destroy(t, terraformOptions)

	// This is annoying, but necessary. Log Group isn't cleaned up correctly after destroy.
	deleteLogGroup(t, "/aws/lambda/ex-tf-bucket-notif")

	// Necessary, as the policy doc needs to exist before applying the lambda func.
	terraformTargetPolicyOptions := &terraform.Options{
		TerraformDir: terraformDir,
		LockTimeout:  "5m",
		Targets: []string{
			"data.aws_iam_policy_document.policy_doc",
		},
	}

	terraform.InitAndApply(t, terraformTargetPolicyOptions)
	terraform.Apply(t, terraformOptions)

	bucket := terraform.Output(t, terraformOptions, "bucket")
	lambdaFunctionARN := terraform.Output(t, terraformOptions, "lambda_function_arn")
	assert.Contains(t, bucket, "ex-tf-bucket-notif")
	assert.Contains(t, lambdaFunctionARN, "ex-tf-bucket-notif")

	attempts := 0
	maxAttempts := 10

	for attempts < maxAttempts {
		_, err := aws.GetS3ObjectContentsE(t, "us-east-1", bucket, "partitioned-test/year=3001/month=01/day=01/hour=01/test.3001-01-01-01.test.gz")
		if err == nil {
			break
		}

		time.Sleep(time.Second * 1)

		attempts++
	}

	if attempts == maxAttempts {
		t.Fatalf("Failed to find object in bucket after %d attempts", maxAttempts)
	}
}
