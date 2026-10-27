FROM nginx:1.27-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
# O HTML único é servido como index — o nome do arquivo fonte se mantém no repo
COPY mapa_brasil_ufs_regioes_melhorado.html /usr/share/nginx/html/index.html

EXPOSE 80
