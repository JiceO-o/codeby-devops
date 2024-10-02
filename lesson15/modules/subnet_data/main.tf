variable "vpc_id" {
  description = "ID VPC для получения информации о subnet"
  type        = string
}

data "aws_subnet_ids" "this" {
  vpc_id = var.vpc_id
}

data "aws_subnet" "subnets" {
  count = length(data.aws_subnet_ids.this.ids)

  id = data.aws_subnet_ids.this.ids[count.index]
}

output "subnet_ids" {
  value = data.aws_subnet_ids.this.ids
}

output "subnet_details" {
  value = data.aws_subnet.subnets[*].id
}
