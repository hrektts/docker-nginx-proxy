FROM jwilder/nginx-proxy:0.4.0
MAINTAINER mps299792458@gmail.com

COPY nginx.tmpl /app/
WORKDIR /app/

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["forego", "start", "-r"]
