variable "environment" {
   default = "dev"
}

variable "project" {
    default = "roboshop"
}

variable "sg_name" {
  type = list 
  default = ["mongodb","redis","sql","rabbitmq",
             #backend
             "catalogue","user","cart","shipping","payment",
             #backend alb
             "backend_alb","frontend","frontend_alb"
             ]
}
