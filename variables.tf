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
variable "ec2_instance_type" {
    type        =  string
    description = "AWS EC2 Instance Type"
    default     = "t2.micro"
}
variable "ignore_ami_changes" {
    type        =  bool
    description = "Whether changes to the AMI ID changes should be ignored by Terraform. Note - changing this value will result in the replacement of the instance"
    default     = false
}

variable "aws_key_pair_name" {
    type        =  string
    description = "AWS EC2 Key pair needed to be associated with EC2"
    default     = "terraform-managed-key"
}

variable "user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead"
  type        = string
  default     = null
}
//----------------------------------------------------------------------
// AWS VPC Variables
//----------------------------------------------------------------------
variable "vpc_cidr" {
  description = "CIDR associated with the VPC to be created"
  default     = "10.0.0.0/16"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  default     = ["10.0.0.0/24"]
  type        = list
}


variable "database_subnets_cidrs" {
  description = "List of CIDR blocks for db subnets"
  default     = ["10.0.200.0/24","10.0.201.0/24"]
  type        = list
}

variable "create_database_subnet_group" {
  description = "Boolean value. Indicate wheter or not to create a database subnet group"
  default     = true
  type        = bool
}