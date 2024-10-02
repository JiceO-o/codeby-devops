module "subnet_data" {
  source = "./modules/subnet_data"
  vpc_id = "twc_vpc"
}

module "vm" {
  source   = "./modules/vm"
  vpc_id   = "twc_vpc"
  zone     = "ru-1"
}
