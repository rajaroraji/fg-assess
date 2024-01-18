provider "aws" {
  region = "us-east-1" # Set your desired AWS region
}

resource "aws_guardduty_detector" "example" {
  enable = var.aws_guardduty_enabeler
}


resource "aws_inspector_resource_group" "example" {
  name = "main-resource-group"
  tags = {
    Name = "main-resource-group"
  }
}
