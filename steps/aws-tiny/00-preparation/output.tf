output "bucket_policy" {
  value = data.aws_iam_policy_document.terraform_bucket_policy
}