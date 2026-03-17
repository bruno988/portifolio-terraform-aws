terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# 3. BUSCADOR DE IMAGEM LINUX
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# 4. CHAVE PÚBLICA
resource "aws_key_pair" "chave_acesso" {
  key_name   = "minha-chave-lab"
  public_key = file("minha-chave.pub") 
}

# 5. SECURITY GROUP (PORTAS 22 E 80)
resource "aws_security_group" "acesso_web" {
  name        = "permitir_acesso_web"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["54.242.56.182/32"] # Coloque seu IP do site meuip.com.br
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 6. INSTÂNCIA EC2 COM NGINX
resource "aws_instance" "servidor_nginx" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.chave_acesso.key_name
  vpc_security_group_ids = [aws_security_group.acesso_web.id]

  user_data = <<-EOF
              #!/bin/bash
              amazon-linux-extras install nginx1 -y
              systemctl start nginx
              systemctl enable nginx

              # Criando os arquivos no servidor buscando da pasta 'website'
              cat <<EOT > /usr/share/nginx/html/index.html
              ${file("website/index.html")}
              EOT

              cat <<EOT > /usr/share/nginx/html/style.css
              ${file("website/style.css")}
              EOT

              cat <<EOT > /usr/share/nginx/html/script.js
              ${file("website/script.js")}
              EOT
              EOF

  tags = {
    Name = "Webserver-Nginx-IaC"
  }
}

output "ip_publico" {
  value = aws_instance.servidor_nginx.public_ip
}