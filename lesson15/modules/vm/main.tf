variable "vpc_id" {
  description = "ID VPC для создания ВМ"
  type        = string
}

variable "zone" {
  description = "Зона для создания ВМ"
  type        = string
}

data "twc_subnet_ids" "this" {
  vpc_id = var.vpc_id
}

data "twc_subnet" "selected_subnet" {
  for_each = toset(data.twc_subnet_ids.this.ids)

  id = each.value
}

resource "twc_instance" "my_vm" {
  ami           = "xxx"
  instance_type = "t2.micro"
  subnet_id     = data.twc_subnet.selected_subnet[0].id

  tags = {
    Name = "MyVM"
  }

  allocation_id = xxx
}
