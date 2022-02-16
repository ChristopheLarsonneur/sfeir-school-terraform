module "app_server" {
  source = "./modules/servers/"

  servers = { 
    for server, data in local.servers : 
      server => data if data.suffix != "-3" && var.environment == "dev" 
  }

  instance_type = each.value.suffix == "-2" ? var.instance_type : local.instance_type

  environmment = var.environment
  server_prefix = var.server_prefix
  
}
