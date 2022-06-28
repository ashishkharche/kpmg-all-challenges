terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


provider "aws" {
  region = var.region
}


module "vpc_build" {
  source              = "./modules/vpc"
  vpc_cdir_block      = var.aws_cidr_block
  public_subnet_1     = var.aws_public_subnet_1
  public_subnet_2     = var.aws_public_subnet_2
  private_subnet_3    = var.aws_private_subnet_3
  private_subnet_4    = var.aws_private_subnet_4
  availability_zone_A = var.aws_availability_zone_A
  availability_zone_B = var.aws_availability_zone_B
  any_ip              = var.aws_any_ip
}


module "web-entity" {
  source          = "./modules/ec2"
  entity_name       = "web"
  ami            = var.ami_id
  instance_type   = var.aws_instance_type
  vpc_id          = module.vpc_build.vpc_id
  public_subnet1  = module.vpc_build.out_publicsubnet1
  public_subnet2  = module.vpc_build.out_publicsubnet2
  private_subnet3 = module.vpc_build.out_privatesubnet3
  private_subnet4 = module.vpc_build.out_privatesubnet4
  out_bastion_ssh = module.vpc_build.out_bastion_ssh
  min_asgp        = var.min_asg_value
  max_asgp        = var.max_asg_value
  out_alb_sg      = module.vpc_build.out_alb_sg
  out_ec2_sg      = module.vpc_build.out_ec2_sg
  user_data_file  = var.ec2_user_data
}


module "app-entity" {
  source          = "./modules/ec2"
  entity_name       = "app"
  ami            = var.ami_id
  instance_type   = var.aws_instance_type
  vpc_id          = module.vpc_build.vpc_id
  public_subnet1  = module.vpc_build.out_publicsubnet1
  public_subnet2  = module.vpc_build.out_publicsubnet2
  private_subnet3 = module.vpc_build.out_privatesubnet3
  private_subnet4 = module.vpc_build.out_privatesubnet4
  out_bastion_ssh = module.vpc_build.out_bastion_ssh
  min_asgp        = var.min_asg_value
  max_asgp        = var.max_asg_value
  out_alb_sg      = module.vpc_build.out_alb_sg
  out_ec2_sg      = module.vpc_build.out_ec2_sg
  user_data_file  = var.ec2_user_data
}


module "db-entity" {
  source                    = "./modules/rds"
  db_allocated_storage      = var.mysql_db_allocated_storage
  db_storage_type           = var.mysql_db_storage_type
  db_engine                 = var.mysql_db_engine
  db_engine_version         = var.mysql_db_engine_version
  db_instance_class         = var.mysql_db_instance_class
  db_name                   = var.mysql_db_name
  db_username               = var.mysql_db_username
  db_password               = var.mysql_db_password
  db_multi_az               = var.mysql_db_multi_az
  db_port                   = var.mysql_db_port
  db_subnetgroup_name       = module.vpc_build.out_rdssubnetgroup
  db_vpc_security_group_ids = module.vpc_build.out_rdsmysqlsg
}