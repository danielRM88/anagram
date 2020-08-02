provider "aws" {
  region = "eu-central-1"
}

locals {
  s3bucketarn = "arn:aws:s3:::anagram-fd-testing"
}

resource "aws_s3_bucket" "lambda_trigger_bucket" {
  count  = "0"
  bucket = "anagram-fd-testing"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  count  = "0"
  bucket = "${aws_s3_bucket.lambda_trigger_bucket.id}"

  lambda_function {
    lambda_function_arn = "${local.s3bucketarn}"
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".csv"
  }
}

resource "aws_lambda_function" "lambda_function" {
  filename         = "is_anagram_payload.zip"
  function_name    = "is_anagram"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "is_anagram.is_anagram"
  runtime          = "python3.6"
  memory_size      = "512"
  timeout          = "60"

  environment {
    variables = {
      region = "eu-central-1"
    }
  }
}

resource "aws_lambda_permission" "allow_s3_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda_function.arn}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${local.s3bucketarn}"
}
