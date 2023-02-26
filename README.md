This module consists of vpc resources.
following variable values you can set according to your requirement. if you doesnt provide values there are defualt values

variable "vpc_cidr" 
default = "10.0.0.0/16"


variable "private_cidr" {
default = "10.0.10.0/24"

variable "public_cidr" {
default = "10.0.1.0/24"

variable "ami"{
default = "ami-0dfcb1ef8550277af"

variable "ec2-type"{
default= "t2.micro"

Following value is required value. you need to have yout own keypair
variable "key-pair"{}