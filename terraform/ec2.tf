resource "aws_instance" "web" {
  ami             = data.aws_ami.ubuntu20.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.ec2.name]
  tags = {
    Name = "HelloWorld"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("../keys/ec2")
    host        = aws_instance.web.public_ip
  }
  provisioner "file" {
    source      = "/tmp/repo"
    destination = "repo"
  }

  provisioner "remote-exec" {
    inline = [
      "cd repo && bash run_server.sh"
    ]
  }

  key_name = aws_key_pair.ec2_ssh.key_name
}  