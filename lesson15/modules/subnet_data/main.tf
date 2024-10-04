variable "vpc_id" {
  description = "ID VPC для получения информации о subnet"
  type        = string
}

data "twc_subnet_ids" "this" {
  vpc_id = var.vpc_id
}

data "twc_subnet" "subnets" {
  count = length(data.twc_subnet_ids.this.ids)

  id = data.twc_subnet_ids.this.ids[count.index]
}

output "subnet_ids" {
  value = data.twc_subnet_ids.this.ids
}

output "subnet_details" {
  value = data.twc_subnet.subnets[*].id
}

output "subnet_by_zone" {
  value = { for s in data.twc_subnet.all_subnets : s.availability_zone => s.id }
}