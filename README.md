# Mapa IBGE — Cobertura Municipal

Visualização interativa dos municípios brasileiros com limites oficiais do IBGE, população (prévia do Censo 2022 / estimativas da API) e ferramentas para exportação.

**Demo local:** http://localhost:8001 (servido via `python -m http.server` ou `docker compose up`)

## Funcionalidades

- **Mapa Leaflet** com basemaps configuráveis (OSM escurecido, Esri Dark Gray, Esri World Imagery), com fallback automático em caso de bloqueio.
- **Navegação por UF → divisão regional (Mesorregião / Microrregião / Município)** e filtro por região específica.
- **Pins por município** com raio proporcional à população, com popup detalhado (nome, código IBGE, população, região, fonte dos dados).
- **Nomes das cidades** com 3 modos: *Auto (por zoom/população)*, *Todos os municípios filtrados* e *Sem nomes*.
- **Filtro de população** com presets rápidos ou valores mínimo/máximo personalizados.
- **Busca por município** com filtro em tempo real.
- **Camadas**: alternar polígonos das regiões, pins e rótulos.
- **Fonte da população**: base embutida (prévia Censo 2022) ou atualização via API do IBGE (estimativa 2026).
- **Exportação XLSX**: gera planilha com os municípios visíveis (respeita todos os filtros). Colunas: Município, Código IBGE, UF, Mesorregião, Microrregião, População, Fonte + linha de totais.
- **Exportação PNG**: captura do mapa como visto na tela (basemap, pins, rótulos e polígonos), em resolução 2×, sem controles da interface.

## Tecnologias

- HTML/CSS/JS (arquivo único, sem build)
- [Leaflet](https://leafletjs.com/) 1.9.4
- [Tailwind CSS](https://tailwindcss.com/) (CDN)
- [SheetJS (xlsx)](https://cdn.sheetjs.com/) — exportação XLSX no navegador
- [html2canvas](https://html2canvas.hertzen.com/) — exportação PNG no navegador
- [API de Localidades / Malhas do IBGE](https://servicodados.ibge.gov.br/api/docs/localidades)
- [API Agregados do IBGE](https://servicodados.ibge.gov.br/api/docs/agregados)

## Rodando localmente

### Opção 1: Python HTTP server (rápido)
```bash
python3 -m http.server 8001
# http://localhost:8001/mapa_brasil_ufs_regioes_melhorado.html
```

### Opção 2: Docker Compose (igual ao Coolify)
```bash
docker compose up --build
# http://localhost:8001
```
O `docker-compose.override.yml` publica a porta 8001 localmente; no Coolify ele é ignorado.

## Deploy no Coolify

Este repositório está pronto para **Docker Compose** no Coolify:

1. **Novo recurso** → *Docker Compose* → conectar este repo (`liderbrinquedos/mapcom`), branch `main`
2. O Coolify detecta `docker-compose.yml` (usa `expose: 80`, **sem `ports:` do host** — compatível com Traefik do Coolify)
3. Em *Domains*, adicionar o FQDN desejado (HTTPS via Let's Encrypt)
4. *Deploy*

Arquivos para deploy:
- `Dockerfile` — nginx:alpine servindo o HTML como `index.html`
- `nginx.conf` — gzip ativado
- `docker-compose.yml` — apenas `expose` (padrão Coolify)
- `.dockerignore` / `.gitignore` — limpeza de arquivos locais

> **Dica:** se houver erro `port is already allocated`, significa que há `ports:` publicado no compose do Coolify — mantenha apenas `expose`.

## Estrutura do projeto

```text
.
├── Dockerfile
├── docker-compose.override.yml
├── docker-compose.yml
├── mapa_brasil_ufs_regioes_melhorado.html
└── nginx.conf
```

## Fontes de dados

- **Limites e divisão territorial:** Malhas e localidades IBGE (v3)
- **População:** Prévia do Censo Demográfico 2022 (IBGE, dezembro/2022) embutida no app. Atualizável para estimativas 2026 via API pública do IBGE.
- **Centroides:** calculados automaticamente a partir dos bounding boxes das malhas GeoJSON.

## Licença

Uso livre para fins de análise e visualização. Dados geográficos e populacionais são de domínio público conforme o IBGE.
