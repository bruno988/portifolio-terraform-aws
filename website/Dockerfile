# Usa a imagem oficial do Nginx
FROM nginx:alpine

# Copia os teus arquivos locais para dentro do servidor Nginx no container
COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/
COPY script.js /usr/share/nginx/html/

# Expõe a porta 80
EXPOSE 80