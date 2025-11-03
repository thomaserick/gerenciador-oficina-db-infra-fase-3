#### LOCALS ####
locals {

  # Subnets públicas — para RDS e Load Balancers
  public_subnets = {
    "1a" = cidrsubnet(var.vpc_cidr, 8, 0)
    "1b" = cidrsubnet(var.vpc_cidr, 8, 1)
    "1c" = cidrsubnet(var.vpc_cidr, 8, 2)
  }
}

#### VPC ####
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name      = "vpc-${var.vpc_name}"
    Terraform = "true"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "igw-${var.vpc_name}" }
}

# Subnets
resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = "us-east-${each.key}"
  map_public_ip_on_launch = true

  tags = {
    Name                                    = "sn-${var.vpc_name}-public-${each.key}"
    "kubernetes.io/role/elb"                = 1
    "kubernetes.io/cluster/${var.vpc_name}" = "shared"
  }
}

# Rota pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = { Name = "rt-public-${var.vpc_name}" }
}

# Associação das subnets públicas à rota pública
resource "aws_route_table_association" "public_assoc" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}