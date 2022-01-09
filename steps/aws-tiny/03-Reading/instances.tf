/* 

Combien de serveurs seront créé si on positionne la variable environment à 'production'?
On fera mieux dans l'exercice suivant, ne vous inquiétez pas...

Comment sont-ils nommés?

Ont-ils des tags? Lesquel?

Quel OS est exploité?

Quel type d'instance pour le server-1? et le serveur-2?

Comment pourrions-nous faire pour changer le type d'intance du server2?
=> Conseil: Regardez les options de la ligne de commande.

Comment pourrions-nous faire pour que le type d'instance soit défini clairement pour la production?
=> Conseil: Le fichier tfvars/production/variable.tfvars est à exploiter de la ligne de commande.
*/

resource "aws_instance" "app_server1" {
  ami           = data.aws_ami.image.id
  instance_type = local.instance_type

  tags = {
    Name = "${var.server_prefix}AppServerInstance${local.servers["server-1"].suffix}-${var.environment}"
  }
}

resource "aws_instance" "app_server2" {
  ami           = data.aws_ami.image.id
  instance_type = var.instance_type

  tags = {
    Name = "${var.server_prefix}AppServerInstance${local.servers["server-2"].suffix}-${var.environment}"
  }
}
