module "us" {
    source = "./module/vpc_module/"
    providers = {
      aws = aws.us
     }
    //vpc_id = aws_default_vpc.default.id
}
module "mu" {
    source = "./module/vpc_module/"
    providers = {
      aws = aws.mu
     }
    //vpc_id = aws_default_vpc.default.id
}

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "nginx_server_sg" {
  name = "nginx_server_sg"
  //vpc_id = "vpc-c49ff1be"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "http_server_sg"
  }
}

resource "aws_instance" "nginx_server" {
    count = 2
  
  #ami                   = "ami-062f7200baf2fa504"
  ami                    = "${data.aws_ami.ubuntu.id}" 
  //ami = lookup(var.ec2_ami,var.region) 
  key_name               = "terraform"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.nginx_server_sg.id]

  //subnet_id              = "subnet-3f7b2563"
  subnet_id = tolist(data.aws_subnet_ids.default_subnets.ids)[0]

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file(var.aws_key_pair)
  }
  tags = {
    # The count.index allows you to launch a resource 
    # starting with the distinct index number 0 and corresponding to this instance.
    Name = "nginx-machine-${count.index}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y",
      "sudo service ngnix start",
      "echo Welcome to Nginx-Server - Virtual Server is at ${self.public_dns} | sudo tee /var/www/html/index.html",
      //"(crontab -l 2>/dev/null; echo " 0 1 * * * init 0 ") | crontab -"
      
    ]
     
  }
}