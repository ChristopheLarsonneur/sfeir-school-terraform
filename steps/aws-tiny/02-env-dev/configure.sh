#!/usr/bin/bash
#
clear
echo "BIENVENUE dans les exercices terraform du workshop AWS!

Nous allons installer une configuration d'AWS pour l'exercice. 
INFO: Si votre poste de travail était déjà configuré (~/.aws existe), il sera renommé en ~/.aws.before-SFEIR-Exercices.

Appuyer sur Enter pour procéder à la configuration. Pour annuler maintenant, presser Ctrl-C."
read

if [[ -d ~/.aws ]] && [[ ! -d ~/.aws.before-SFEIR-Exercices ]]
then
   mv -v ~/.aws ~/.aws.before-SFEIR-Exercices
   sleep 2
fi

mkdir -p ~/.aws
clear
echo "Votre formateur vous a transmis un fichier excel avec les clés AWS pour votre compte.
Veuillez l'ouvrir et copier coller les données requises au moment ou elles vous seront données.
"

ANS=no
while [[ "$ANS" != "yes" ]]
do
  echo "Veuillez indiquer la clé (AWS ACCESS KEY) à utiliser:"
  read AWS_ACCESS_KEY
  echo "Veuillez indiquer la clé secrète (AWS SECRET KEY) à utiliser:"
  read AWS_SECRET_KEY

  echo "Voici un résumé:
AWS_ACCESS_KEY: $AWS_ACCESS_KEY
AWS_SECRET_KEY: $AWS_SECRET_KEY

Veuillez confirmer ces informations. Tapez 'yes' pour poursuivre."

  read ANS

  if [[ "$ANS" = "yes" ]]
  then
    cat credentials | sed '
    s|<AWS_ACCESS_KEY>|'"$AWS_ACCESS_KEY"'|g
    s|<AWS_SECRET_KEY>|'"$AWS_SECRET_KEY"'|g
    '> ~/.aws/credentials

    if [[ "$(which aws 2>/dev/null)" = "" ]]
    then 
      echo "Le fichier credentials vient d'être créé. Veuillez vérifier la connectivité AWS avec 'aws sts get-caller-identity'"
    else
      echo "Vérification de la configuration AWS"
      if [[ "$(aws sts get-caller-identity | grep workshop-user)" = "" ]]
      then
        echo "Il y a un souci avec vos clés. Veuillez renouveler la configuration avec les bonnes clés."
        exit 1
      fi
      echo "Le fichier credentials vient d'être vérifié. tout semble bon. Amusez-vous bien!"
    fi
  fi
done

echo '[default]
region = eu-west-3
' > ~/.aws/config

mkdir -p $HOME/.terraform.d/plugin-cache
echo 'plugin_cache_dir   = "$HOME/.terraform.d/plugin-cache"' > ~/.terraformrc

echo "Vous pouvez désormais aller sur votre exercice."
