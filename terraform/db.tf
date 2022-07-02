resource "aws_db_instance" "default" {
  allocated_storage    = 5
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "mydb"
  username             = "immortal"
  password             = random_password.db_password.result
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  vpc_security_group_ids = [
    aws_security_group.rds_dev_test.id,
    aws_security_group.db_ec2.id
  ]
  publicly_accessible = true # Only for dev testing should remove later.
}
