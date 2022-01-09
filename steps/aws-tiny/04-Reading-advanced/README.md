# Lire un code terraform

Prenez le temps de lire ce que le code réalise et de répondre aux questions qui y sont inscrites en commentaires.

Ensuite, vous pouvez lancer un plan ou un apply pour voir ce qu'il donne.

1. Executez un deployement en dev

    ```bash
    terraform apply --var-file tfvars/dev/variables.tfvars
    ```

2. Executez un deployement en production

    ```bash
    terraform apply --var-file tfvars/production/variables.tfvars
    ```

    PS: Remarquez la destruction du dev... Nous aborderons ce soucis avec les workspace de terraform.

3. Supprimez vos ressources

    ```bash
    terraform destroy
    ```
