/* Comment exploiter un module à la place. */

resource "aws_instance" "app_server" {
  for_each = { 
    for server, data in local.servers : 
      server => data if data.suffix != "-3" && var.environment == "dev" 
  }

  ami           = data.aws_ami.image.id

  instance_type = each.value.suffix == "-2" ? var.instance_type : local.instance_type

  tags = {
    Name = "${var.server_prefix}AppServerInstance${each.value.suffix}-${var.environment}"
  }
}
