#!/usr/bin/bash
#

if [[ "$WORKSHOP" = "" ]]
then
  echo "Veuillez exporter le nom de votre workshop avec la commande export. Ex:
  export WORKSHOP=workshop_1

  Puis relancer la commande tf_init.sh
  "
  exit 1
fi
set -x
terraform init -backend-config ../workshops/$WORKSHOP.tfvars
