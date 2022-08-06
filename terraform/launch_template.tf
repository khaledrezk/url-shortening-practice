resource "aws_launch_template" "webserver" {
  name_prefix   = "webserver"
  image_id      = data.aws_ami.backend.id
  instance_type = "t2.micro"
  user_data = filebase64("./userdata.sh")
  vpc_security_group_ids = [aws_security_group.ec2.id]
  key_name = "ec2_ssh"
}
