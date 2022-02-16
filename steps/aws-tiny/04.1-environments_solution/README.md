# Solution : Lire et paramétrer un code terraform

1. terraform init

   ```bash
   $ terraform init

   Initializing the backend...
   bucket
   The name of the S3 bucket

   Enter a value: tf-workshop-m6

   key
   The path to the state file inside the bucket

   Enter a value: workshop_X


   Successfully configured the backend "s3"! Terraform will automatically
   use this backend unless the backend configuration changes.

   Initializing provider plugins...
   - Finding hashicorp/aws versions matching "~> 3.27"...
   - Installing hashicorp/aws v3.74.2...
   - Installed hashicorp/aws v3.74.2 (signed by HashiCorp)

   Terraform has created a lock file .terraform.lock.hcl to record the provider
   selections it made above. Include this file in your version control repository
   so that Terraform can guarantee to make the same selections by default when
   you run "terraform init" in the future.

   Terraform has been successfully initialized!

   You may now begin working with Terraform. Try running "terraform plan" to see
   any changes that are required for your infrastructure. All Terraform commands
   should now work.

   If you ever set or change modules or backend configuration for Terraform,
   rerun this command to reinitialize your working directory. If you forget, other
   commands will detect it and remind you to do so if necessary.
   ```

   Pour palier à ce setup manuel, le fichier terraform.tf a été modifié.

2. Advanced backend configuration

    ```bash
    terraform init -backend-config ../
    ```

3. dev deploy

    ```bash
    terraform workspace new dev # Pour créer un workspace
    terraform apply --var-file tfvars/dev/variables.tfvars
    ```

4. prod deploy

    ```bash
    terraform workspace new production # Pour créer un workspace
    terraform apply --var-file tfvars/production/variables.tfvars
    ```

5. Cleanup

    ```bash
    terraform select dev
    terraform destroy
    terraform select production # pour basculer sur l'environnement de production
    terraform destroy
    ```
