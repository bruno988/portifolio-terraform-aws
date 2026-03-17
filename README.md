🚀 Infrastructure as Code & CI/CD Pipeline: Website Deploy
Este repositório contém a automação completa para o deploy de um portfólio pessoal na AWS, utilizando Terraform para a infraestrutura e GitHub Actions para a esteira de CI/CD.

🛠️ Tecnologias Utilizadas
Terraform: Provedor AWS para provisionamento de instâncias EC2, VPC, Subnets e Security Groups.

Docker: Containerização da aplicação utilizando Nginx.

GitHub Actions: Automação de Build, Login no Docker Hub e Push da imagem.

AWS (EC2): Hospedagem da infraestrutura na nuvem.

🏗️ Arquitetura do Projeto
O projeto é dividido em três camadas principais:

Application: Localizada na pasta /website, contendo o HTML/CSS e o Dockerfile.

Infrastructure: Arquivos .tf que definem a rede e os servidores necessários.

Pipeline: Workflow em YAML que garante que qualquer alteração no código reflita automaticamente na imagem do container.

🚀 Como Executar o Projeto
Pré-requisitos
Conta na AWS com CLI configurada.

Conta no Docker Hub.

Terraform instalado localmente.

Passo 1: Configurar Secrets no GitHub
No seu repositório, vá em Settings > Secrets and variables > Actions e adicione:

DOCKERHUB_USERNAME: Seu usuário do Docker Hub.

DOCKERHUB_TOKEN: Seu Personal Access Token do Docker Hub.

Passo 2: Provisionar Infraestrutura
PowerShell
cd terraform
terraform init
terraform apply -auto-approve
Passo 3: Deploy Automático
Ao realizar um git push para a branch main, o GitHub Actions irá:

Realizar o login no Docker Hub.

Construir a imagem Docker a partir do /website/Dockerfile.

Enviar a imagem para o seu repositório no Docker Hub.

A instância EC2, ao ser iniciada pelo Terraform, buscará automaticamente essa imagem e subirá o serviço na porta 80.

📈 Aprendizados
Durante o desenvolvimento deste projeto, aprofunduei conhecimentos em:

Depuração de falhas de autenticação em pipelines automatizados.

Gestão de Security Groups e regras de entrada/saída na AWS.

Uso de User Data no Terraform para automação de scripts de inicialização de instâncias (instalação de Docker e execução de containers)..
