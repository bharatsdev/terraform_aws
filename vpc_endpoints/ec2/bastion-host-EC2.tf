resource "aws_instance" "BASTION_HOST" {
  ami                         = var.aws_ami_id
  instance_type               = "t2.micro"
  key_name                    = var.tf_key_name
  subnet_id                   = var.public_subnet_id
  security_groups             = [var.public_sg_id]
  associate_public_ip_address = true
  tags = {
    "Name" = "BASTAIN_HOST"
    "VPC"  = "AWS_NETWORKING"
  }
}
# EIP
resource "aws_eip" "BASTAIN_HOST_IP" {}


resource "aws_eip_association" "BASTION_HOST_EIP_MAPPING" {
  allocation_id = aws_eip.BASTAIN_HOST_IP.id
  instance_id   = aws_instance.BASTION_HOST.id
}
