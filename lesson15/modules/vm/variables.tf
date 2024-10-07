variable "subnet_ids_by_zone" {
  description = "Словарь subnet_id, сгруппированных по зонам"
  type        = map(string)
}

variable "zone" {
  description = "Зона для создания ВМ"
  type        = string
}