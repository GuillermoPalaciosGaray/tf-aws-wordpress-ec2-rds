module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.0.0"

  # Required variables
  name                   = "public-ec2-${var.environment}"
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.ec2_instance_type
  key_name               = aws_key_pair.aws_key_pair.key_name
  monitoring             = true
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public-ec2-security-group.this_security_group_id]
  ignore_ami_changes     = var.ignore_ami_changes
  user_data              = data.template_file.webserver_launch_configuration_user_data.rendered

  tags                   = var.tags

}

data "template_file" "webserver_launch_configuration_user_data" {
  template = file("${path.module}/template/user_data.sh")
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "aws_key_pair" {
  key_name   = var.aws_key_pair_name
  public_key = tls_private_key.private_key.public_key_openssh
}