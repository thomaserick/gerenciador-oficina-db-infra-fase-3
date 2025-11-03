# VPC
output "vpc_id" {
  description = "ID da VPC principal"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR da VPC"
  value       = aws_vpc.main.cidr_block
}

# Internet Gateway
output "internet_gateway_id" {
  description = "ID do Internet Gateway"
  value       = aws_internet_gateway.gw.id
}

# Subnets
output "public_subnet_ids" {
  description = "Lista de IDs das subnets públicas"
  value       = [for subnet in aws_subnet.public : subnet.id]
}


