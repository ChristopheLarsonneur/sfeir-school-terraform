/* Combien de serveurs seront créé si on positionne la variable environment à 'dev'?
   Combien de serveurs seront créé si on positionne la variable environment à 'production'?

   En production, quel est le type d'instance du `server-2` ? */

// => Conseil: Les fichiers `tfvars/*/variable.tfvars` sont à exploiter à partir de la ligne de commande, pour activer le bon environment.


resource "aws_instance" "app_server" {
  for_each = var.servers

  ami           = data.aws_ami.image.id
  instance_type = each.value.instance_type

  tags = {
    Name = "${var.server_prefix}AppServerInstance${each.value.suffix}-${var.environment}"
  }
}
