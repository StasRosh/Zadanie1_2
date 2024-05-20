# Etap 1: Budowanie aplikacji Node.js
FROM node:alpine AS build
WORKDIR /usr/app

# Skopiowanie plików aplikacji
COPY ./package.json ./
RUN npm install

# Skopiowanie pozostałych plików aplikacji
COPY ./index.js ./

# Zdefiniowanie wersji aplikacji jako argumentu budowania
ARG VERSION
ENV APP_VERSION=$VERSION

# Etap 2: Budowanie obrazu końcowego na bazie Nginx
FROM nginx:latest

# Instalacja supervisora
RUN apt-get update && apt-get install -y supervisor

# Skopiowanie plików z etapu 1 do katalogu serwera Nginx
COPY --from=build /usr/app /usr/share/nginx/html

# Skopiowanie pliku konfiguracyjnego supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Ustawienie domyślnego portu
EXPOSE 80

# Uruchomienie supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
