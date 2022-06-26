output "db_name" {
  value = aws_db_instance.default.db_name
}

output "db_username" {
  value = aws_db_instance.default.username
}

output "db_password" {
  value     = random_password.db_password.result
  sensitive = true
}

output "db_port" {
  value = aws_db_instance.default.port
}

output "db_endpoint" {
  value = aws_db_instance.default.endpoint
}

output "vpc_id" {
  value = aws_default_vpc.default.id
}

output "my_ip" {
  value = chomp(data.http.my_ipv4.response_body)
}
