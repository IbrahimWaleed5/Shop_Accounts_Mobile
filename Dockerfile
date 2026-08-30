FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

COPY . .

ARG API_BASE_URL
RUN flutter build web --release --dart-define=API_BASE_URL=${API_BASE_URL}

FROM caddy:2-alpine

COPY --from=build /app/build/web /usr/share/caddy

COPY Caddyfile /etc/caddy/Caddyfile

EXPOSE 8080