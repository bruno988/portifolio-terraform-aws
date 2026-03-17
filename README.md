# Projeto AWS Terraform - Nginx Webserver 🚀

Este repositório contém o código para provisionar uma infraestrutura automatizada na AWS.

## 📋 O que este código faz:
- Cria um par de chaves para acesso seguro.
- Configura regras de Firewall (Security Group).
- Sobe uma instância EC2 rodando Amazon Linux 2.
- Instala e configura o Nginx automaticamente via script Bash.

## 🛠️ Como usar:
1. Altere o IP no `main.tf`.
2. Rode `terraform init` e `terraform apply`.