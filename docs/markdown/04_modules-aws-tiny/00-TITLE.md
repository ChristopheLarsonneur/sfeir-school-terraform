<!-- .slide: class="transition"-->

# Structurer le code, l'infrastructure et travail en équipe

##==##
<!-- .slide: -->

# HashiCorp Configuration Language (HCL)

<br/>

## Module

**Un module est un ensemble de ressources.**  
Il permet d’abstraire un déploiement plus complexe et agit comme une boîte noire pour laquelle on utilisera des **variables** en entrée et des **outputs** en sortie.

**Le module permet une réutilisation du code et peut être stocké dans un repository distant (ex: git)(privé ou publique).**

En terme de structure à un code terraform standard.

```
.
├── main.tf
├── project.tf
├── README.md
├── outputs.tf
└── variables.tf
```

##==##
<!-- .slide: -->
# Structuration du code source

## Gestion des fichiers et bonnes pratiques

Il n’y a pas de normes imposées par l’outil mais un ensemble de bonnes pratiques :

* Tous les fichiers *.tf sont automatiquement analysés lors de l'exécution de terraform
* Il est possible de dissocier les variables et outputs du code
* Chaque “feature” peut faire l’objet d’un nouveau fichier .tf
* Les tests sont regroupés dans un dossier test
* Les modules peuvent être stockés localement
* Les valeurs par défaut pour les variables doivent être évitées
* Les modules peuvent être en local. Mais la plupart du temps, ils sont dans des repos dédiés ou publiques.

```
.
├── main.tf
├── modules
│   ├── instances
│   │   └── ec2.tf
├── project.tf
├── README.md
├── outputs.tf
└── variables.tf
```

##==##
<!-- .slide:-->

# Travail en équipe

## tfstate & remote state

Le fichier tfstate contient une liste des resources mise en oeuvre par terraform sur le cloud provider.
Ce fichier en format json est essentiel pour terrafom pour garantir une stabilité de l'infrastructure décrite.
Il peut servir pour interroger les ressources dans d'autre processus, notamment d'autre configation terarform.

Par défaut, il est local. et faillible.

La plupart des providers propose l'hébergement du state dans des ressources cloud sécurisé. Pour AWS, il s'agit de
bucket S3.

Exemple:

```terraform
terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "eu-west-3"
}}
```

NOTE: ATTENTION! le state peut contenir des données sensibles, qui ne sont pas chiffrés.

##==##
<!-- .slide:-->

# Travail en équipe

## remote state

Recommendations pour state sur bucket S3:

- non publique
- versionné
- Evitez le state partagé entre code terraform. 

  Préférez un export vers un autre bucket S3, maitrisé (contenu/iam) via s3_object
- le bucket S3 peut être partagé par plusieurs code terraform, moyennant une gestion
  de droit plus fine.

##==##
<!-- .slide:-->

# Travail en équipe

## le state et les workspaces

Par défaut, terraform stocke (localement ou à distance) le state attaché à un workspace
'default'.

via `terraform workspace`, il est possible de distinguer plusieurs déploiement à partir 
du même code.
Souvent utilisé pour gérer le multi-environment, le projet, etc...

exemple:

```bash
terraform new production # Crée un workspace production pour tracker les resources production
terraform set production # Active un workspace production existant.
```

Le nom du workspace est interrogeable dans le code via `terraform.workspace`

exemple:

```terraform
locals {
  environment = terraform.workspace # grab workspace name as the environment to deploy.
}
```


##==##
<!-- .slide: class="exercice" -->

# state AWS bucket S3

## Atelier

Consultez [l'exercice 5](https://github.com/ChristopheLarsonneur/sfeir-school-terraform/tree/aws-variant/steps/aws-tiny/05-module-state)

Positionner le remote state sur un bucket S3 à créer.