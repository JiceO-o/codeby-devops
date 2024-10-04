module "subnet_data" {
  source = "./modules/subnet_data"
  vpc_id = "twc_vpc"
}

module "vm" {
  source = "./modules/vm"
  
  subnet_ids_by_zone = { 
    for zone, id in module.subnet_data.subnet_by_zone : zone => id
  }

  zone = "ru-1"
}