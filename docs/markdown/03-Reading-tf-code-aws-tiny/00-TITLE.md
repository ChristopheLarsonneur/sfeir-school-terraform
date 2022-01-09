<!-- .slide: class="transition"-->

# Lire du code terraform

##==##
<!-- .slide:-->

# HashiCorp Configuration Language (HCL)

<br/>

Ref: [https://github.com/hashicorp/hcl](https://github.com/hashicorp/hcl)

Langage de configuration développé par HashiCorp et ré-utilisé dans ses différents produits. Uniquement déclaratif, il est associé au HIL (HashiCorp Interpolation Language) lorsqu’il faut calculer des valeurs.

##==##
<!-- .slide: -->  

# HashiCorp Configuration Language (HCL)

<br/>

## Mots clefs pour Terraform

* **provider, variable, resource, module, output, data**
* Commentaires via `#`, `//` ou `/* … */`
* Les valeurs sont assignées avec cette syntaxe : `key = value`
* Multi-line via <<EOF … EOF

exemples:

```terraform
/* Ceci est un commentaire */
// Ca aussi.
# Et ca aussi!

# Un des mots clé: Une resource
resource "aws_instance" "myinstance" {
  ...
}
```

##==##
<!-- .slide:-->

# HashiCorp Configuration Language (HCL)

<br/>

## Type de variables

HCL a de nombreux types de variable comme : 
* String via “...”
* Nombre
* Booléen
* List via `[ … ]`
* Map via `{ ... }`
* Structure anonyme (object)
* Type complexe (list de map, map de list, map de map de map, …)

Exemple:

```terraform
variable "test" {
  type = string
}

locals {
  test = "A string value"
  test_map = {
    key1 = "value1"
  }
}
```

Notes:
Contrairement à la map, tous les champs d'un object sont de même type


##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

<br/>

## Exemple

```hcl-terraform
provider "aws" {
  region = "eu-west-3"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

<br/>

## Variables

Les variables permettent d’adapter les attributs en fonction de différents critères comme l’environnement, le type d’application, etc…

Déclaration : 

```hcl-terraform
variable "num_cpu" {
 type = number
 description = "This variable define the number of CPU"
 default = 2
}
```
<!-- .element: class="big-code" -->

Utilisation : 
```hcl-terraform
num_cpu = var.num_cpu      // préconisé
tags    = "tag:${var.tag}" // avec expansion
```

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

<br/>

## Variables : Custom validation rules

Le developpeur peut imposer aux utilisateurs des contraintes sur la valeur des variables, telles que :
* Un élément présent dans une liste prédéfinie
* Des expressions régulières
* Des formats (date, lowercase, taille d'une chaine de caractères)

Exemple : un identifiant en minuscule de plus de 4 lettres
```
variable "id" {
  type        = string
  description = "Primaty ID used for the user"

  validation {
    condition     = length(var.id) > 4 && lower(var.id) == var.id
    error_message = "Require at least 4 characters in lower case."
  }
}
```


##==##
<!-- .slide: class="with-code-bg-dark" -->
# HashiCorp Configuration Language (HCL)

<br/>

## Variables : le récap

Les variables supportent les attributs suivant :
* **default** : assigne une valeur par défaut qui peut être surchargée
* **type** : définit le type de la variables (par défaut string mais il est possible d'utiliser des variables de type bool, map, list, ...)
* **description** : aide l'utilisateur à définir le contenu de la variable
* **validation** : permet de rejeter une valeur si elle ne respecte pas les conditions
* **sensitive** : interdit l'affichage de la valeur au travers d'outputs et masque son contenu dans la console

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

<br/>

## Variables locales

Une `local` est l'association d'une expression à une variable, afin d'être réutilisée plusieurs fois dans un module.

Déclaration : 
```hcl-terraform
locals {
  # Simple string
  region = "europe-west4"
  # List
  instance_names = ["inst-a", "inst-b"]
  # Ids for multiple sets of EC2 instances, merged together
  instance_ids = concat(aws_instance.blue.*.id, aws_instance.green.*.id)
}
```
<!-- .element: class="big-code" -->

Utilisation :
```hcl-terraform
resource "..." "..." {
  instance_names = [local.instance_names]
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

<br/>

## Provider

Le provider fournit un ensemble de primitives permettant de lire, créer, modifier ou supprimer des ressources sur la plateforme distante.
* Chaque provider possède ses propres attributs
* Il est possible d’utiliser plusieurs déclarations d’un même provider en utilisant l’attribut spécial “alias” (appelé meta-parameter).
* Les variables utilisées pour configurer les providers doivent être calculables avant un plan
* Il est fortement conseillé d'utiliser des variables d'environnement pour configurer les providers

<br>

Ref provider AWS : [https://registry.terraform.io/providers/hashicorp/aws/latest/docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
<!-- .element: class="big-code" -->

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

<br/>

## Resource
Les ressources sont les composantes de l’infrastructure. 
Elles peuvent être une instance, un loadbalancer, une règle firewall, etc, …<br/>
Elles doivent respecter la syntaxe : resource "TYPE" "NAME”

```hcl-terraform
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  tags = {
    Name = "allow_tls"
  }
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide:-->

# HashiCorp Configuration Language (HCL)

<br/>

## Resource - Meta parameters

Boucles:

* **count** : Permet de créer plusieurs fois la ressource. count.index permet de récupérer l’index courant
* **for_each** : Pour créer plusieurs fois une ressource en utilisant une map ou une liste de strings (depuis 0.12 à privilégier par rapport à count)

Autres:

* **lifecycle** : Permet de modifier le cycle de vie de la ressource
* **depends_on** : Forcer une dépendance
* **provider** : Permet de surcharger le provider de la ressource
* **timeouts** : Configurer les timeouts des opérations de création, modification et suppression
* **provisioner** : Permet d'exécuter des scripts en local ou à distance

Notes:
Example :

lifecycle : Permet de modifier le cycle de vie de la ressource (créer la nouvelle avant de supprimer l’ancienne, ignorer les changements d’un attributs, ...)

depends_on : Forcer une dépendance. Par défaut toute “variable interpolée” crée une dépendance implicite. Dans certains cas, il est necessaire d’expliciter la dépendance (exemple, créer une base de donnée avant le serveur d’application).

provider : Permet de surcharger le provider de la ressource par exemple lors de l’utilisation d’alias sur plusieurs providers.

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

<br/>

## Output

Les outputs sont affichés en surbrillance à la fin du déploiement Terraform. 

Ils permettent aux utilisateurs d’afficher des attributs calculés ou retournés par le provider.
<br/>
<br/>
```hcl-terraform
output "addresses" {
 value = [aws_instance.web.*.public_dns]
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HashiCorp Configuration Language (HCL)

<br/>

## Data source

Le data source permet de récupérer des attributs non gérés par Terraform, et donc en lecture seule.

```hcl-terraform
variable "security_group_id" {}

data "aws_security_group" "selected" {
  id = var.security_group_id
}

resource "aws_subnet" "subnet" {
  vpc_id     = data.aws_security_group.selected.vpc_id
  cidr_block = "10.0.1.0/24"
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide:-->

# Terraform settings

Il existe un "block" hors de toute ressource pour définir le comportement du déploiement :
* Forcer les versions à utiliser
* Configurer le backend
* Activer des fonctionnalitées expérimentales

```
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source = "hashicorp/aws"
    }
  }
  backend "remote" {
    organization = "example_corp"
    workspaces {
      name = "my-app-prod"
    }
  }
  experiments = [something]
}
```

##==##
<!-- .slide: class="exercice" -->

# Commençons à lire un code terraform

## Atelier

Consultez [l'exercice 3](https://github.com/ChristopheLarsonneur/sfeir-school-terraform/blob/aws-variant/steps/aws-tiny/03-Reading)

Et répondez aux questions inscrites dans le code.

**Note**:
Si vous créez les resources, pensez à les détruire:

`terraform destroy`

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Comment assigner des valeurs aux variables lors de l'exécution d’une action terraform (plan, apply ou destroy) ?

<br/>

1. terraform <action> -var ‘key=value’
2. terraform <action> -var-file ‘path_to_file’
3. export KEY=value; terraform \<action>
4. export TF_VAR_key=value; terraform \<action>
5. en ajoutant un fichier *.auto.tfvars dans le répertoire courant

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Comment assigner des valeurs aux variables lors de l'exécution d’une action terraform (plan, apply ou destroy) ?

<br/>

1. **terraform <action> -var ‘key=value’**
2. **terraform <action> -var-file ‘path_to_file’**
3. export KEY=value; terraform \<action>
4. **export TF_VAR_key=value; terraform \<action>**
5. **en ajoutant un fichier *.auto.tfvars dans le répertoire courant**

Attention, l’ordre des variables à une importance. Les CLI sont toujours prioritaires. En cas de conflit, le dernier argument prévaut (sauf dans le cas d’une map où les clefs différentes sont fusionnées)

Notes:
Values passed within definition files or with -var will take precedence over TF_VAR_ environment variables, as environment variables are considered defaults.

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : A quoi sert la chaîne de caractères qui suit le type d’une ressource ?

<br/>

1. à définir le “display name” de l’objet créé sur la plateforme
2. à identifier la ressource pour la manipuler dans Terraform
3. ce n’est pas encore utilisé
4. à remplacer l’UID de la ressources si elle est définie

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : A quoi sert la chaîne de caractères qui suit le type d’une ressource ?

<br/>

1. à définir le “display name” de l’objet créé sur la plateforme
2. **à identifier la ressource pour la manipuler dans Terraform**
3. ce n’est pas encore utilisé
4. à remplacer l’UID de la ressources si elle est définie


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quel est le comportement de Terraform lors du prochain apply si une ressource a été commentée depuis le dernier apply ?

<br/>

1. Rien, il n’y a pas de changement des attributs
2. Terraform va supprimer la ressource
3. Terraform va ignorer la ressource
4. Une erreur à la compilation

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quel est le comportement de Terraform lors du prochain apply si une ressource a été commentée depuis le dernier apply ?

<br/>

1. Rien, il n’y a pas de changement des attributs
2. **Terraform va supprimer la ressource**
3. Terraform va ignorer la ressource
4. Une erreur à la compilation

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quelle est la particularité d'une variable de type *object* ?

<br/>

1. Le résultat est toujours ordonné
2. Ce n'est pas la plus utilisée
3. Peut contenir de nombreux types différents

##==##
<!-- .slide: -->

# QUIZZ

<br/>

*Question* : Quelle est la particularité d'une variable de type *object* ?

<br/>

1. Le résultat est toujours ordonné
2. Ce n'est pas la plus utilisée
3. **Peut contenir de nombreux types différents**

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL-extended


Il est possible de manipuler des variables, récupérer des attributs d’autres ressources ou utiliser des fonctions native directement dans notre code :

```hcl-terraform
data "template_file" "example" {
 template = file("templates/greeting.tpl")
 vars {
   hello = "goodnight"
   world = "moon"
 }
}
```

Usage
```hcl-terraform
resource "aws_instance" "web" {
  ami              = "ami-d05e75b8"
  instance_type    = "t2.micro"
  user_data_base64 = data.template_file.example.rendered
}
``` 

Il reste néanmoins possible (mais déprécié) d'utiliser l'ancien format via l'utilisation de `"${ ... }"`

Par exemple : `"${data.template_file.example.rendered}"`

<!-- .element: class="big-code" -->

##==##
<!-- .slide:-->

# HCL extended (also known as HIL)

<br/>

## Lier les attributs

Il est possible de lire la valeur d’un attribut d’une ressource, d’une source de donnée, d’une variable, …
* resource : `resource_type.resource_name.attribut`
* variable : `var.variable_name`
* module : `module.module_name.output_name`
* data source : `data.data_type.data_name.attribut`

Cas d’une liste de resource : `resource_type.resource_name[<index>].attribut`

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL extended (also known as HIL)

<br/>

Il existe de nombreuses fonctions [documentées en ligne](https://www.terraform.io/docs/language/functions/index.html).

Exemple d’utilisation :

```hcl-terraform
  count     = length(var.shortnames)
  upper-foo = upper(var.foo)
  encoded   = base64encode(var.sensitive_content)
```  
<!-- .element: class="big-code" -->

Ref : [https://www.terraform.io/language/functions](https://www.terraform.io/language/functions)

##==##
<!-- .slide:-->

# HCL extended (also known as HIL)

<br/>

## Boucles sur les resources

Terraform permet de déployer plusieurs ressources de même type via une unique déclaration en utilisant le “meta parameter" for_each(ou count).<br/>

![h-400 center](./assets/images/hil_boucle.png)

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL extended (also known as HIL)

<br/>

## Boucles sur les resources

Depuis la version 0.12, Terraform a introduit une nouvelle manière d’itérer **For-Each** (à privilégier par rapport à count).

```hcl-terraform
resource "vault_ldap_auth_backend_group" "group-users" {
  for_each  = local.bindings
  groupname = each.key
  policies  = tolist(keys(each.value))
  backend   = vault_ldap_auth_backend.ldap.path
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL extended (also known as HIL)

<br/>

## Boucles sur des variables/locals

* Construire une map en bouclant sur une map/tableau dans une variable, un local ou une colection de resources/datas

  ```terraform
  { for [<k>],     <v> in <map>   : <newkey> => <new value> }

  { for [<index>], <v> in <array> : <newkey> => <new value> }
  ```

* Construire un tableau indicé en bouclant sur une variable, un local ou une collection de resources/datas

  ```terraform
  [ for [<k>],     <v> in <map> : <new value> ]

  [ for [<index>], <v> in <map> : <new value> ]

**NOTE**: Il est possible de faire des boucles de boucles pour des calculs/transformations complexes.

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL extended (also known as HIL)

<br/>

## Boucles sur des variables/locals

Exemple:

```hcl-terraform
locals {
  map = {
    key1 = "value1"
    key2 = "value2"
  }

  map_redesigned = { for k, v in local.map: k => upper(v) }
  array = [ for k, v in local.map: upper(v) ]
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL extended (also known as HIL)

<br/>

## Conditions

Les conditions permettent de définir des valeurs différentes en fonction des variables ou d’autres attributs.

```hcl-terraform
resource "google_compute_instance" "web" {
   machine_type = var.env == "production" ? var.prod_size : var.dev_size
}
```

##==##
<!-- .slide: class="exercice" -->

# Continuons à lire un code terraform

## Atelier

Consultez [l'exercice 4](https://github.com/ChristopheLarsonneur/sfeir-school-terraform/blob/aws-variant/steps/aws-tiny/04-Reading-advanced)

Et répondez aux questions inscrites dans le code.

**Note**:
Si vous créez les resources, pensez à les détruire:

`terraform destroy`

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Comment obtenir un élément d’une liste ?

<br/>

1. var.list[position]
2. element(var.list, position)
3. list[position]
4. lookup(var.list, position)

##==##
<!-- .slide:-->

# QUIZZ

<br/>

Question : Comment obtenir un élément d’une liste ?

<br/>

1. **var.list[position]**
2. **element(var.list, position)**
3. list[position]
4. lookup(var.list, position)
