# Sfeir workshop Terraform

## Module 2 Installation and Configuration

### Configuration des exercices

1. Installons git: (si nécessaire)

    => [https://git-scm.com/downloads](https://git-scm.com/downloads)

2. Récupérons les exercices

    ```bash
    $ git clone https://github.com/ChristopheLarsonneur/sfeir-school-terraform.git -b aws-variant
    Cloning into 'sfeir-school-terraform'...
    remote: Enumerating objects: 1806, done.
    remote: Counting objects: 100% (430/430), done.
    remote: Compressing objects: 100% (279/279), done.
    remote: Total 1806 (delta 230), reused 230 (delta 96), pack-reused 1376
    Receiving objects: 100% (1806/1806), 25.22 MiB | 2.98 MiB/s, done.
    Resolving deltas: 100% (780/780), done.
    $ cd sfeir-school-terraform/steps/aws-tiny/01-installation
    $ 
    ```

3. Installons terraform

    Utilisez le bash de git pour tous les exercices.

    ```bash
    $ mkdir -p ~/bin
    ```

    Téléchargez la version de votre OS et placez le binaire dans le répertoire ~/bin.

    https://www.terraform.io/downloads

4. Tester l'installation

    Vous devez peut-être relancer bash pour que terraform soit trouvé.

    ```bash
    $ terraform --version
    Terraform v1.1.3
    on windows_amd64
    + provider registry.terraform.io/hashicorp/null v3.1.0
    ```

### Executons notre premier code terraform

```bash
terraform workspace new module-2
terraform init
terraform plan
terraform apply
```

Result should be

```text
null_resource.check-version: Creation complete after 0s (ID: 2069855020914050742)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

message = Hello World
```

### Regardez le contenu de l'arborescence après le premier run

Nous pouvons constater plusieurs fichiers et répertoires en plus...

```bash
$ ls -la
total 14
drwxr-xr-x 1 CLarsonneur 1049089    0 Jan  9 23:32 ./
drwxr-xr-x 1 CLarsonneur 1049089    0 Jan  9 23:32 ../
drwxr-xr-x 1 CLarsonneur 1049089    0 Jan  9 23:32 .terraform/
-rw-r--r-- 1 CLarsonneur 1049089 1077 Jan  9 23:32 .terraform.lock.hcl
-rw-r--r-- 1 CLarsonneur 1049089 1139 Jan  9 23:32 README.md
-rw-r--r-- 1 CLarsonneur 1049089  215 Jan  9 23:32 main.tf
-rw-r--r-- 1 CLarsonneur 1049089   46 Jan  9 23:32 versions.tf
```
