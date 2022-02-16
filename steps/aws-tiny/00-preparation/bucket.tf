resource "aws_s3_bucket" "terraform" {
  bucket = local.terraform_state_bucket.name
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }
}

resource "aws_s3_account_public_access_block" "private" {
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "private" {
  bucket = aws_s3_bucket.terraform.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

// Build policy document from terraform_bucket.policies
data "aws_iam_policy_document" "terraform_bucket_policy" {

  dynamic "statement" {
    for_each = flatten([ 
      for policy in local.terraform_state_bucket.policies: [
        for index, account_id in try(policy.each_accounts, false) ? local.accounts: ["ignored"] : 
          merge( policy, { 
            account_id   = account_id
            account_name = "workshop_${index+1}"
          }
        )
      ]
    ])

    content {
      actions = statement.value.actions

      principals {
        type = "AWS"
        identifiers = try(statement.value.each_accounts, false) ? flatten([ // Assign this policy to the account_id/user
          [ for user in local.users : "arn:aws:iam::${statement.value.account_id}:user/${user}" ],
          [ for role in local.roles : "arn:aws:iam::${statement.value.account_id}:role/${role}" ]
        ]) : flatten([
          for account in local.accounts : [ // Assign this single policy to the list of all accounts users.
            [ for user in local.users : "arn:aws:iam::${account}:user/${user}"], 
            [ for role in local.roles : "arn:aws:iam::${account}:role/${role}"], 
          ]
        ])
      }

      resources = try(statement.value.each_accounts, false) ? flatten([ 
        "${aws_s3_bucket.terraform.arn}/${statement.value.account_name}/*",
        "${aws_s3_bucket.terraform.arn}/:env/*",
        ]) : [aws_s3_bucket.terraform.arn ]

    }
  }

}

resource "aws_s3_bucket_policy" "terraform_bucket_policy" {
  bucket = aws_s3_bucket.terraform.id

  policy = data.aws_iam_policy_document.terraform_bucket_policy.json
}

