data "aws_vpc" "defvpc" {
  default = true
}

data "aws_subnet" "defsubnet1" {
  id = "subnet-0d0dd612c916e9132" #1b 
}
data "aws_subnet" "defsubnet2" {
  id = "subnet-06fcef8296be557f2" #1a
}