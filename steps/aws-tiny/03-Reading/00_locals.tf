locals {
  # Définit une liste de serveurs à créer
  # Quel type de local avons-nous affaire ici?
  servers = {
    "server-1" = {
      /* Décrit le suffix du premier serveur */
      suffix = "-1"
    }

    /* Un 2ème serveur */
    "server-2" = {
      suffix = "-2"
    }
  }

  instance_type = "t2.micro"
}