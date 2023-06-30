variable "tf_key_name" {
  default = "myrsa"
}

variable "public_subnet_id" {}


variable "public_sg_id" {}

variable "private_subnet_id" {}

variable "private_sg_id" {}

variable "aws_ami_id" {
  default = "ami-049a62eb90480f276"
}
