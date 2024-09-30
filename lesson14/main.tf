terraform {
  required_providers {
    twc = {
      source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
    }
  }
  required_version = ">= 1.4.4"
}

provider "twc" {
  token = "eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsImtpZCI6IjFrYnhacFJNQGJSI0tSbE1xS1lqIn0.eyJ1c2VyIjoiY2oyOTExOCIsInR5cGUiOiJhcGlfa2V5IiwicG9ydGFsX3Rva2VuIjoiNjM5Mjk2ZjEtZTgzZC00ZGM1LTkyNjQtY2VjMTExZWIyNTI2IiwiYXBpX2tleV9pZCI6IjZkZDYyM2VhLWZkZWMtNDE2Yy1iZjU1LTJjMzAzZjg2NjdhMyIsImlhdCI6MTcyNzE5ODcwM30.s260E_NiZD_zCdDMAxU92PNnjO6a8DE_zWl_62dZT8y_4_dtRj4SVyHDWXWPuChVbjapBw3PiFHjuaYf5ezifXqYd-l4BMqn5sLyahVYEjhlDWXP45Fu3tBZeTMc7MRAt4ed87zo7PX8NpXmwAICwvrp8mbEolz5hnGlYrI3JiMm1lGgeJL3WD0zOpU1uoBPo0si1z0mzarqFooRovyFb3ykL6n9ppCmp8v-LlfB6YpbYsm0tWNmUQERyn9Pk-X3fFo3mvdjDx0hZk_VPXM1tOKQtly9l3QZTLsu0x2m1e5oSuw6G0eXX2_d8stsGCUcXoX1Djotv9yov0p-EIcG14KqibtK2mS8wQFOKvzgOJmeNnWtyAtqjyQMfnOWlnz9ykFCNivWSuKkNO2iZPLAeJcjUVQ8fe_aOug2jx1J-2RsQwdSA8wNiRp4qL1Xsmag25Ad9V9dBpQ1olf3zRVhsvv83BZAdvw6slTtoAaL-S33A_YQyw94XFc_T2JYc2tH"
}

resource "twc_vpc" "private" {
  subnet_v4 = "10.0.1.0/24"
  location = "ru-1"
  name = "private"
}

resource "twc_vpc" "public" {
  subnet_v4 = "10.0.2.0/24"
  location = "ru-1"
  name = "public"
}


data "twc_configurator" "configurator" {
  location = "ru-1"
  disk_type = "nvme"
}

data "twc_os" "os" {
  name = "ubuntu"
  version = "20.04"
}

resource "twc_ssh_key" "your-key" {
  name = "Your key"
  body = file("keys/terraform-key.pub")
}

resource "twc_server" "public_server" {
  name = "public_server"
  os_id = data.twc_os.os.id

  ssh_keys_ids = [twc_ssh_key.your-key.id]

  configuration {
    configurator_id = data.twc_configurator.configurator.id
    disk = 15360
    cpu = 2
    ram = 1024 * 4
  }

  local_network {
    id = twc_vpc.public.id
    ip = "10.0.2.4"
  }

    connection {
    type     = "ssh"
    user     = "root"
    private_key = file("keys/terraform-key")
    host = "10.0.2.4"
  }

  provisioner "remote-exec" {
      inline = [
        "sudo apt-get update",
        "sudo apt-get install -y nginx",
        "sudo systemctl start nginx",
        "sudo systemctl enable nginx"
      ]
    }
  }

resource "twc_server" "private_server" {
  name = "private_server"
  os_id = data.twc_os.os.id

  ssh_keys_ids = [twc_ssh_key.your-key.id]

  configuration {
    configurator_id = data.twc_configurator.configurator.id
    disk = 15360
    cpu = 2
    ram = 1024 * 4
  }

  local_network {
    id = twc_vpc.private.id
    ip = "10.0.1.4"
  }

  connection {
    type     = "ssh"
    user     = "root"
    private_key = file("keys/terraform-key")
    host = "10.0.1.4"
  }

  provisioner "remote-exec" {
      inline = [
        "sudo apt-get update",
        "sudo apt-get install -y nginx",
        "sudo systemctl start nginx",
        "sudo systemctl enable nginx"
      ]
    }

}

resource "twc_firewall" "public-firewall" {
  name = "public-firewall"
  description = "Some example firewall"

  link {
    id = resource.twc_server.public_server.id
    type = "server"
  }
}

resource "twc_firewall" "private-firewall" {
  name = "private-firewall"
  description = "Some example firewall"

  link {
    id = resource.twc_server.private_server.id
    type = "server"
  }
}

resource "twc_firewall_rule" "public-80" {
  firewall_id = resource.twc_firewall.public-firewall.id
  description = "Some example firewall rule"

  direction = "ingress"
  port = 80
  protocol = "tcp"
  cidr = "0.0.0.0/0"
}

resource "twc_firewall_rule" "public-443" {
  firewall_id = resource.twc_firewall.public-firewall.id
  description = "Some example firewall rule"

  direction = "ingress"
  port = 443
  protocol = "tcp"
  cidr = "0.0.0.0/0"
}

resource "twc_firewall_rule" "public-22" {
  firewall_id = resource.twc_firewall.public-firewall.id
  description = "Some example firewall rule"

  direction = "ingress"
  port = 22
  protocol = "tcp"
  cidr = "0.0.0.0/0"
}

resource "twc_firewall_rule" "private-8080" {
  firewall_id = resource.twc_firewall.private-firewall.id
  description = "Some example firewall rule"

  direction = "ingress"
  port = 8080
  protocol = "tcp"
  cidr = "0.0.0.0/0"
}

resource "twc_firewall_rule" "private-22" {
  firewall_id = resource.twc_firewall.private-firewall.id
  description = "Some example firewall rule"

  direction = "ingress"
  port = 22
  protocol = "tcp"
  cidr = "0.0.0.0/0"
}

