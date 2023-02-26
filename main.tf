provider "aws" {
  region = var.region

}
resource "aws_vpc" "project" {
  cidr_block = var.vpc_cidr
  tags = {
    "name" = "myvpc"


  }

}
resource "aws_subnet" "public" {
  #name="public-sebnet"
  vpc_id                  = aws_vpc.project.id
  cidr_block              = var.public_cidr
  map_public_ip_on_launch = true
  tags = {
    "name" = "demo"

  }
}
resource "aws_subnet" "private" {

  #name="private-sebnet"
  vpc_id     = aws_vpc.project.id
  cidr_block = var.private_cidr
  tags = {
    "name" = "demo"
  }

}
resource "aws_internet_gateway" "my" {
  vpc_id = aws_vpc.project.id
  tags = {

    Name = "main"
  }

}
resource "aws_route_table" "public-routetable" {
  vpc_id = aws_vpc.project.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my.id
  }

  tags = {
    name = "example"
  }

}
resource "aws_route_table_association" "eg" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public-routetable.id


}
resource "aws_route_table" "private-routetable" {
  vpc_id = aws_vpc.project.id


  tags = {
    name = "example"
  }
}
resource "aws_route_table_association" "eg1" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private-routetable.id


}
resource "aws_security_group" "ssh_security" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.project.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}
/*
resource "aws_instance" "demo1" {
  ami           = var.ami # us-east-1
  instance_type = var.ec2-type

  subnet_id       = aws_subnet.public.id
  security_groups = [aws_security_group.ssh_security.id]
  key_name        = var.key-pair
  user_data       = file("install-httpd.sh")

}

resource "aws_instance" "demo12" {
  ami           = "ami-0dfcb1ef8550277af" # us-east-1
  instance_type = "t2.micro"

  subnet_id       = aws_subnet.public.id
  security_groups = [aws_security_group.ssh_security.id]
  key_name        = aws_key_pair.demo.key_name
 


}


resource "aws_key_pair" "demo" { #this is key pair of ec2
  key_name   = "test"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDpc07kGZ9hQQve347Z5UudA72UIdjqWkMaIxu58Zuy0m0FD2W6q8Y8uE/nXD3F/jhNKYYKh+vRUJWzRxay3wjRFxzC7oNVUNE7DGyzCu8CqFm/oiTUXNg5+61q25Iabh+1AXUJWIamxIM7Ol735alBIW9ZIfrMUZzYYOoWfEhIl+/ht40PSjOrZMdfSibYZFJlXx42KYQW2EoUhO5om+TeldtGaqUo9wiA3T9OYum3bSjy4q/E5nXv3+wwzaEXpCSWGz1gAXt4ZvN0X5Xaf8U7vIz4p6FUBDTpvbIfkp9nhp2FBED43/WbsheZwWPFFq8OKc0j+0Bb5l9nNxC0/zSa5dt1jP0l0maZX0nPYUwV/bNjw7PW3g1x8wZxowXuplDwquz0/c4xWmKq0We5k82zlV7LYgS9636TynEwlmYkAFha2b+fOnE/a4FVqQByJUqm4nFOkxC3p0qT7URagQp4qfENzvh7ukkuMx6TUmeDtC1tUuw0GX4TUdn5jxFWKpM= farhan@farhan-PC"

}
resource "aws_eip" "sample" {
  instance = aws_instance.demo1.id
  vpc      = true
}
resource "aws_s3_bucket" "sample1" {
  bucket = "my-tf-test-bucket-afifa"
  
  #acl    = "private"

  versioning {
    enabled = true
  }
}
*/
