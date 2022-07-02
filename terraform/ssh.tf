resource "aws_key_pair" "ec2_ssh" {
  key_name   = "ec2_ssh"
  public_key = file("../keys/ec2.pub")
}