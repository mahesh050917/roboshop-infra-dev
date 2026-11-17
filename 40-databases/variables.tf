variable "environment" {
   default = "dev"
}

variable "project" {
    default = "roboshop"
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "tags" {
  type    = map(any)
  default = {}
}

