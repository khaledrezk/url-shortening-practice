resource "aws_security_group" "rds_dev_test" {
  name        = "rds_dev_test"
  vpc_id      = aws_default_vpc.default.id
  description = "Allow access to database from my personal laptop."
  ingress {
    from_port   = var.rds_port
    to_port     = var.rds_port
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ipv4.response_body)}/32"]
  }
}

resource "aws_security_group" "ec2" {
  name        = "ec2"
  vpc_id      = aws_default_vpc.default.id
  description = "Allow access to database from my personal laptop."
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ipv4.response_body)}/32"]
  }
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ipv4.response_body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_ec2" {
  name        = "db_ec2"
  vpc_id      = aws_default_vpc.default.id
  description = "Allow connections from ec2 to db"
  ingress {
    from_port       = var.rds_port
    to_port         = var.rds_port
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2.id]
  }
}