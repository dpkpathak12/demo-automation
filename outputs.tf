output "aws_security_group_nginx_server_details" {
  value = aws_security_group.nginx_server_sg
}

#output "http_server_public_dns" {
# value = aws_instance.nginx_server.public_dns
#}
output "ubuntu_ami" {
  value = data.aws_ami.ubuntu
}