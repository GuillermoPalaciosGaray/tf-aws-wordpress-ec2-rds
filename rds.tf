##################################################################
# RDS MySQL Instance
##################################################################
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.0.0"

  identifier                = "${var.prefix}-${var.environment}-db"

  engine                    = var.rds_engine
  engine_version            = var.rds_engine_version
  create_db_parameter_group = var.create_db_parameter_group
  create_db_option_group    = var.create_db_option_group
  skip_final_snapshot       = var.skip_final_snapshot

  instance_class            = var.rds_instance_class
  allocated_storage         = var.allocated_storage
  max_allocated_storage     = var.max_allocated_storage

  username                  = var.rds_username
  db_name                   = var.rds_db_name
  create_random_password    = var.create_random_password

  db_subnet_group_name      = module.vpc.database_subnet_group_name
  multi_az                  = var.is_multi_az_enabled
  subnet_ids                = module.vpc.database_subnets
  vpc_security_group_ids    = [module.db_sg.security_group_id]
  tags                      = var.tags
}
