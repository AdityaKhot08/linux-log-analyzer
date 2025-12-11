# Optional: serve the static site using nginx
FROM nginx:alpine
COPY . /usr/share/nginx/html
