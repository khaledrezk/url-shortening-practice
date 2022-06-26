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