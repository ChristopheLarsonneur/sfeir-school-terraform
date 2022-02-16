# Exploiter des modules

Avant de poursuivre, pour vous simplifier la vie, positionnez le nom de votre workshop sous WORKSHOP, ajoutez un PATH sur des petits scripts, et lancez l'init.

Ex:

```bash
$ export WORKSHOP=workshop_1
$ export PATH=$PATH:$(pwd)/../workshops/bin
$ tf_init.sh
[...]
$
```

1. Nous allons écrire un module terraform pour centraliser la création de serveurs EC2

  Dans cet exemple, nous le considérerons local. Mais généralement, les modules sont dans des repos distincts gérés par d'autres équipes...

  le module existe déjà. Il suffit de l'exploiter. Je vous propose de modifier le fichier `instance.tf`

  Consultez l'aide de terraform sur internet pour appeler une resource module.

  Ensuite lancez/fixez le code via terraform validate/plan/apply.

2. Pensez-vous que le simple fait de modifier le fichier instance.tf est suffisant? A l'execution, oui. Mais en réalité, il est possible de faire du nettoyage. 

  Astuce: Rappelez vous des dépendances implicites...

RDV au prochain exercice...