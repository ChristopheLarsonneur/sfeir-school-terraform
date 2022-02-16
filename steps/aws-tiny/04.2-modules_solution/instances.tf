module "app_server" {
  source = "./modules/servers/"

  servers = { 
    for server, data in local.servers : 
      server => merge(
        data , {
          instance_type = each.value.suffix == "-2" ? var.instance_type : local.instance_type
        }) if data.suffix != "-3" && var.environment == "dev" 
  }

  environmment = var.environment
}
