variable "bucket_name" {
  description = "variable name for s3 bucket"
  type        = string
  default     = "nussypoox42"
}

#Variables for ec2_sg.terraform {

variable "ami_id" {
  description = "ami_id for aws linux instance"
  type        = string
  default     = "ami-0bb84b8ffd87024d8"
}

variable "az" {
  description = "availability for aws linux instance"
  type        = string
  default     = "us-east-1a"
}
variable "key" {
  description = "authentication key for aws linux instance"
  type        = string
  default     = "vskey"
}
variable "instance_type" {
  description = "instance_type for aws linux instance"
  type        = string
  default     = "t2.micro"
}

