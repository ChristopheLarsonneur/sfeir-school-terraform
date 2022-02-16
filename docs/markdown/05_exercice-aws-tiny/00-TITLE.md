<!-- .slide: class="transition"-->

# Exercices terraform

##==##
<!-- .slide: -->

# exercice 1 - création d'un serveur EC2 + PK/SG et doc

Dans cet exercice, nous allons modifier un code existant pour ajouter des ressources manquantes:

- public key pair
- security_group

Nous exploiterons terraform-docs pour produire la documentation.

Ref de l'exercice : [https://github.com/ChristopheLarsonneur/sfeir-school-terraform/tree/aws-variant/steps/aws-tiny/05-1-ec2](https://github.com/ChristopheLarsonneur/sfeir-school-terraform/tree/aws-variant/steps/aws-tiny/05-1-ec2)

##==##
<!-- .slide: -->

# exercice 1 - fonctionnement de terraform-docs

- Basé sur les commentaires, identifié via `/** **/`

  ```terraform
  /** 
    Comment extracted as code document
  **/

- descriptions des variables et des output

  ```terraform
  variable "blabla" {
    description = "my description"
  }

  output "bloblo" {
    description = "my output description"
  }
  ```

- liste les resources, modules, providers et les versions exploité/décrite

##==##
<!-- .slide: -->

# exercice 2 - gestion des réseaux (cidr) automatique

Dans cet exercice, nous manipulerons les VPC et subnet pour affecter par regions/zone, une série de CIDR qui n'entre pas en conflit.

Nous exploiterons les principalement des fonctions terraform tel que [cidrsubnets](https://www.terraform.io/language/functions/cidrsubnets)

La documentation sera aussi à réaliser.

Ref de l'exercice : [https://github.com/ChristopheLarsonneur/sfeir-school-terraform/tree/aws-variant/steps/aws-tiny/05-2-vpc](https://github.com/ChristopheLarsonneur/sfeir-school-terraform/tree/aws-variant/steps/aws-tiny/05-2-vpc)

##==##
<!-- .slide: class="transition" -->

# Merci

## Questions?
