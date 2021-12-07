provider "aws" {
    region = "us-east-1"
}

variable "cidr_blocks" { 
  description = "cidr blocks and name tags for vpc and subnets" //değişti
  default = [{cidr_block:"10.0.0.0/17", name:"default-vpc"}, //değişti
  {cidr_block ="10.0.31.0/24", name: "default-subnet"}] //değişti
  type = list(object({ //değişti
      cidr_block = string //değişti
      name = string //değişti
  }))
}

resource "aws_vpc" "gelistirici-vpc" {
    cidr_block = var.cidr_blocks[0].cidr_block //değişti
    tags = { 
        Name: var.cidr_blocks[0].name //değişti
        vpc_env = "dev" 
    }
}

resource "aws_subnet" "dev-subnet-1"{
    vpc_id = aws_vpc.gelistirici-vpc.id
    cidr_block = var.cidr_blocks[1].cidr_block //değişti
    availability_zone = "us-east-1a"
    tags = { 
        Name:var.cidr_blocks[1].name //değişti
    } 
}

resource "aws_subnet" "dev-subnet-2"{
    vpc_id = aws_vpc.gelistirici-vpc.id
    cidr_block = "10.0.20.0/24"
    availability_zone = "us-east-1b"
        tags = { 
        Name:"subnet-2-default" 
    } 
}

output "dev-vpc-id" {
    value = aws_vpc.gelistirici-vpc.id
}

output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-1.id
}