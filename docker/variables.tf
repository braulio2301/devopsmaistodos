variable "vpc_id" {}

data "aws_vpc" "maistodos_vpc" {
  id = var.vpc_id
  default = true
}