/* 
  Dans quel environment par défaut, les ressources seront créé? Comment changer cela?

  Connaissez-vous cette commande terraform: terraform dispose d'une commande pour reformater le source selon des critères de lecture commune.

  Vous pouvez esseyer de l'utiliser: `terraform fmt`

  Et vérifier ce qu'il se passe dans votre code.

  Vous pouvez réaliser un `git diff` pour voir les changements apporter par terraform fmt, principalement dans ce fichier.

  terraform fmt est très commun et une forte recommendation. On le trouve souvent dans des git hook ou dans des pipelines pour détecter s'il est nécessaire de faire un fmt (check tf fmt)
  Essayez de voir comment détecter si le format néssecite d'être mis à jour via les bonnes options de `terraform fmt`
*/

variable "server_prefix" {
  type = string
  default = "Example"
}

variable "environment" {
  type = string
  default = "dev"
  description = "Environment to deploy"
}

variable "instance_type" {
  type = string
  default = "t2.small"
}