output "bastion_host_ip" {
  value = aws_eip.BASTAIN_HOST_IP.address
}