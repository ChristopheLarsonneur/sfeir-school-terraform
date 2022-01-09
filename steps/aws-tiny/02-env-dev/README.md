# Installer tous les outils

## Les outils

1. Installons AWS cli (V2)

    => [https://docs.aws.amazon.com/fr_fr/cli/latest/userguide/install-cliv2.html](https://docs.aws.amazon.com/fr_fr/cli/latest/userguide/install-cliv2.html)

2. Installons notre IDE :

    => [https://code.visualstudio.com/Download](https://code.visualstudio.com/Download)

3. Sur VisualStudio code, installons le plugin terraform:

    ![](../../../docs/assets/images/plugin_tf.png)

## Configurez AWS

```bash
$ cd 02-env-dev
$ ./configure.sh
[...]
Veuillez indiquer la clé (AWS ACCESS KEY) à utiliser:
AKIASHXGDJJEHVW3FZNA
Veuillez indiquer la clé secrète (AWS SECRET KEY) à utiliser:
[...]
Le fichier credentials vient d'être créé. Veuillez vérifier la connectivité AWS avec 'aws sts get-caller-identity'
$
```

## Utilisez visualStudio code

Naviguer dans le code de l'exercice précédent.

## Installez terraform-docs

Choisissez la version et installez la dans le répertoire bin.

https://github.com/terraform-docs/terraform-docs/releases/tag/v0.16.0

Testez-le sur le précédent exercice

```bash
cd ../01-installation
terraform-docs.exe markdown . > TF.md
```

Consultez le fichier TF.md généré.