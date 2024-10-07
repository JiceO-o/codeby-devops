variable "subnet_ids_by_zone" {
  description = "Словарь subnet_id, сгруппированных по зонам"
  type        = map(string)
}

variable "zone" {
  description = "Зона для создания ВМ"
  type        = string
}

resource "aws_instance" "my_vm" {
  ami           = "xxx" 
  instance_type = "t2.micro"
  subnet_id     = lookup(var.subnet_ids_by_zone, var.zone, null)

  tags = {
    Name = "MyVM"
  }
}
