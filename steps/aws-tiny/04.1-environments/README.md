# Lire et paramétrer un code terraform

Prenez le temps de lire ce que le code réalise et de répondre aux questions qui y sont inscrites en commentaires.

Ensuite, vous pouvez lancer les commandes tel que décrite ci-dessous pour voir ce que donne l'execution de ce code terraform.

1. Commencez par initialiser votre code terraform avec `terraform init`

    Ce code est prévu pour exploiter un bucket s3 pour héberger votre tfstate.
    Chacun d'entre vous dispose d'un espace dédié à votre workshop dans un bucket S3 partagé.

    - Le nom du bucket S3 est `tf-workshop-m6`
    - Le chemin que vous avez l'autorisation d'exploiter est le nom de votre workshop `workshop_X` ex: `workshop_5`

    Maintenant, lancez la commande `terraform init` et voyez ce qu'il vous demande et répondez aux questions.

    Bon, c'est bien de poser les questions. Mais bon, habituellement, on stocke cela dans un fichier quelque part.

    Ou devons nous mettre ces informations? Astuce: Il s'agit de la configuration du backend.

2. Amélioration de la configuration des backends.

   En règle générale, la configuration du backend reste dans le fichier source terraform que vous avez positionné au point 1.

   Mais parfois, on souhaite paramétrer le backend en fonction de divers critères. Dans notre cas, d'ailleurs, nous souhaiterions
   choisir le bon `tfvars` pour son workshop.

   Je nous ai créé ces paramètres dans un fichier sous ../workshops/workshop_*.tfvars. ex: `../workshops/workshop_5.tfvars

   Essayez de trouver une option pour exploiter ce fichier à la place de modifier le code source ou répondre aux questions de `terraform init`

3. Maintenant, executez un déploiment en dev

    ```bash
    terraform apply --var-file tfvars/dev/variables.tfvars
    ```

    Et vérifiez les réponses aux questions dans le code avec la réalité de ce que le code a effectué.

    Petite remarque: Si vous n'avez pas réaliser l'amélioration de la configuration du backend, vous risquez de tomber sur une erreur de droits:

    ```bash
    $ terraform apply -auto-approve
    aws_instance.app_server["server-2"]: Creating...
    aws_instance.app_server["server-1"]: Creating...
    aws_instance.app_server["server-2"]: Still creating... [10s elapsed]
    aws_instance.app_server["server-1"]: Still creating... [10s elapsed]
    aws_instance.app_server["server-2"]: Still creating... [20s elapsed]
    aws_instance.app_server["server-1"]: Still creating... [20s elapsed]
    aws_instance.app_server["server-2"]: Creation complete after 22s [id=i-02e12db8e31d1e4f1]
    aws_instance.app_server["server-1"]: Creation complete after 22s [id=i-091679fc71ed62c93]
    ╷
    │ Error: Failed to save state
    │ 
    │ Error saving state: failed to upload state: AccessDenied: Access Denied
    │       status code: 403, request id: 4V5M034YCYA6M119, host id: jTS9RttvCX99E9yrnqHg58JseZ93NDpPoKUxpd/ICvRomlcWItq3GzZMEAxRZTu2Tut9984V3rk=
    ╵
    ╷
    │ Error: Failed to persist state to backend
    │ 
    │ The error shown above has prevented Terraform from writing the updated state to the configured backend. To allow for recovery, the state has been written to the file "errored.tfstate" in the current working directory.
    │ 
    │ Running "terraform apply" again at this point will create a forked state, making it harder to recover.
    │ 
    │ To retry writing this state, use the following command:
    │     terraform state push errored.tfstate
    ```

    Si tel est le cas, corriger votre appel à `terraform init`, puis comme suggéré, faite un `terraform state push errored.tfstate`

4. Nous souhaitons maintenant déployer en production.

   Executez un déploiment en production avec la commande suivante.

    ```bash
    terraform apply --var-file tfvars/production/variables.tfvars
    ```

   Remarquez la destruction du dev... C'est ennuyeux.
   Comment pensez-vous que nous pourrions faire pour conserver les 2 environments? Astuce: regardez la notion de workspace.

   Veuillez noter que dans la "vrai vie", les 2 environnements (ou plus) sont sur des comptes AWS différents. Un compte par environnement comme recommandé par AWS.
   Dans notre exemple, on exploite un seul compte: votre compte de workshop.

5. Il est temps de clore le sujet.

   Supprimez vos ressources en dev **ET** en production. la commande de destruction est la suivante:

    ```bash
    terraform destroy
    ```

    Comment faire pour tout supprimer? Pas d'astuce: Normalement vous devriez savoir comment le faire assez facilement...

Rendez-vous au prochain et dernier exercice.
