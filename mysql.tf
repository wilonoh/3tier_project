# rds mysql
resource "aws_db_instance" "three_tier_sql" {
  allocated_storage    = var.mysql_allocated_storage
  db_name              = var.mysql_db_name
  engine               = "mysql"
  engine_version       = var.mysql_engine_version
  instance_class       = var.mysql_instance_class
  username             = var.mysql_username
  password             = var.mysql_password
  storage_type         = var.mysql_storage_type
  publicly_accessible  = var.mysql_publicly_accessible
  port                 = "3306"
  #parameter_group_name = "three_tier_sql.mysq8.0.28"
  #parameter_group_name = "default.mysql5.7"
  skip_final_snapshot   = var.mysql_skip_final_snapshot
#   vpc_id                   = aws_vpc.three_tier_vpc.id
  db_subnet_group_name  = aws_db_subnet_group.rds_mysql_subnet_group.id
  tags = {
    name = var.three_tier_sql_name
  }
}

resource "aws_db_subnet_group" "rds_mysql_subnet_group" {
  name       = var.rds_mysql_subnet_group_name
  subnet_ids = [aws_subnet.app_private_sub1.id, aws_subnet.app_private_sub2.id]

  tags = {
    Name = var.rds_mysql_subnet_group_name
  }
}

# # missing parameters
# vpc_id
# db_port ---- 3306

