terraform {
  backend "s3" {
    bucket  = "nussypoox42"
    key     = "state-files/terraform.tfstate"
    region  = "us-east-1"
    profile = "tfuser"

  }
}
