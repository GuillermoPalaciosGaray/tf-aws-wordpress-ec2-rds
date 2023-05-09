//----------------------------------------------------------------------
// Shared  Variables
//----------------------------------------------------------------------

variable "region" {
  description = "AWS Region where the resources are going to be deployed."  
  default     = "us-west-2"
  type        = string
}

variable "prefix" {
  description = "Prefix for all the resources to be created."
  default     = "wordpress"
  type        = string
}

variable "availability_zones" {
  description = "Prefix for all the resources to be created."
  default     = "wordpress"
  type        = string
}

variable "environment" {
  description = "Name of the application environment. e.g. dev, uat, prd"
  default     = "dev"
  type        = string
  validation {
    condition     = contains(["dev","uat","prd"],var.environment)
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "tags" {
  description = "AWS Tags to add to all resources created;"
  type        = map(any)
  default = {
    terraform_managed = true
  }
}

//----------------------------------------------------------------------
// AWS EC2 Variables
//----------------------------------------------------------------------

//----------------------------------------------------------------------
// AWS VPC Variables
//----------------------------------------------------------------------


variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  default     = ["10.0.0.0/24"]
  type        = list
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  default     = ["10.0.100.0/24"]
  type        = list
}

variable "database_subnets_cidrs" {
  description = "List of CIDR blocks for db subnets"
  default     = ["10.0.200.0/24"]
  type        = list
}

variable "create_database_subnet_group" {
  description = "Boolean value. Indicate wheter or not to create a database subnet group"
  default     = true
  type        = bool
}