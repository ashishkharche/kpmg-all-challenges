
resource "aws_db_instance" "rds_build" {
  allocated_storage      = var.db_allocated_storage
  storage_type           = var.db_storage_type
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  multi_az               = var.db_multi_az
  port                   = var.db_port
  db_subnet_group_name   = var.db_subnetgroup_name
  vpc_security_group_ids = [var.db_vpc_security_group_ids]
  tags = {
    name = "rds-db"
  }
}