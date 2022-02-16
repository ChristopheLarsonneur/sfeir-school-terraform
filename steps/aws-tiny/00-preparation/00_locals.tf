locals {

  accounts = [
      "154027641416",
      "632603685465",
      "597391742157",
      "537938274650",
      "868218459381",
      "807292270421",
      "985278943962",
      "460435721956",
      "244850043289",
      "565849521641",
      "669289556242",
      "476440929530",
      "259159663064",
      "091850330784",
      "782677520017"
    ]
  
  users = ["workshop-user"]
  roles = ["OrganizationAccountAccessRole"]

  
  
  terraform_state_bucket = {
    name = "tf-workshop-m6"
    policies = [{ # List buckets for all accounts workshop user
      actions = ["s3:GetBucketLocation", "s3:ListBucket"]
      },{ # update buckets for each accounts workshop user on the dedicated numbered workshop path
      actions = ["s3:GetObject", "s3:PutObject"]
      each_accounts = true
      }]
  }

  default_region = "eu-west-3"
}
