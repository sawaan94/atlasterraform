resource "aws_instance" "practicevm" {
  availability_zone = "us-east-1a"
  ami               = "ami-0bb84b8ffd87024d8"
  instance_type     = "t2.micro"
  tags = {
    Name = "practicevm"
  }
}