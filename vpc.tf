module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name                         = "${var.prefix}-${var.environment}-vpc"
  cidr                         = var.vpc_cidr
  azs                          = data.aws_availability_zones.this.names
  create_database_subnet_group = var.create_database_subnet_group
  public_subnets               = var.public_subnet_cidrs
  database_subnets             = var.database_subnets_cidrs

  tags = var.tags
}
