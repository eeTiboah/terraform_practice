provider "aws" {
  region = "eu-west-2"
}

variable "cidr_blocks" {
  description = "CIDR blocks for subnet and vpc"
  type = list(object({
    name       = string
    cidr_block = string
  }))
}


resource "aws_vpc" "development-vpc" {
  cidr_block = var.cidr_blocks[0].cidr_block
  tags = {
    "Name" = var.cidr_blocks[0].name
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id            = aws_vpc.development-vpc.id
  cidr_block        = var.cidr_blocks[1].cidr_block
  availability_zone = "eu-west-2a"
  tags = {
    "Name" = var.cidr_blocks[1].name
  }
}

output "dev-vpc-id" {
  value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
  value = aws_subnet.dev-subnet-1.id
}
