locals {
  # Définit une liste de serveurs à créer
  servers = {
    "server-1" = {
      /* Décrit le suffix du premier serveur */
      suffix = "-1"
    }

    /* Un 2ème serveur */
    "server-2" = {
      suffix = "-2"
    }

    /* Un 3ème serveur */
    "server-3" = {
      suffix = "-3"
    }
  }

  instance_type = "t2.micro"
}