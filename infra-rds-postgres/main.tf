## VPC Config ##
module "vpc" {
  source   = "../modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.project_name
}


# SG Config ##
module "sg_rds" {
  source     = "../modules/security_group/"
  vpc_cidr   = var.vpc_cidr
  vpc_id     = module.vpc.vpc_id
  depends_on = [module.vpc]
}

## RDS Config ##
module "rds" {
  source                    = "../modules/rds/single"
  rds_name                  = var.project_name
  database_subnets          = module.vpc.public_subnet_ids
  security_group_id         = [module.sg_rds.security_group_id]
  rds_engine                = var.aws_rds_engine
  rds_engine_version        = var.aws_rds_engine_version
  rds_instance_class        = var.aws_rds_instance_class
  rds_storage_type          = var.aws_rds_storage_type
  db_parameter_group_family = var.db_parameter_group_family

  depends_on = [module.sg_rds]
}


