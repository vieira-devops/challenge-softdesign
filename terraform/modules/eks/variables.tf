variable "vpc_id" {
  type = string
}

variable "vpc_private_subnets" {
  type = set(string)
}