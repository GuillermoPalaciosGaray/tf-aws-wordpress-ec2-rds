module "public-ec2-security-group" {
    source      = "terraform-aws-modules/security-group/aws"
    version     = "4.9.0"
    
    name        = "public-ec2-sg-${var.environment}"
    description = "Security Group with SSH port open for everybody (IPV4 CIDR), egress ports are all world open"
    
    # Mandatory attribute
    vpc_id      = module.vpc.vpc_id

    #Ingress Rules & CIDR Blocks
    ingress_with_cidr_blocks = [
        {
          description = "SSH access from anywhere"
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = "0.0.0.0/0"
        },
        {
          description = "HTTP access from anywhere"
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = "0.0.0.0/0"
        }
    ]
    
    #Egress Rules & CIDR Blocks
    egress_rules       = ["all-all"]
    egress_cidr_blocks = ["0.0.0.0/0"]
    tags = var.tags
}

module "db_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "${var.prefix}-${var.environment}-db-sg"
  description = "MySQL Security Group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = module.public-ec2-security-group.security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1 

  tags = var.tags
}