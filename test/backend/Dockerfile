FROM python:3
MAINTAINER mps299792458@gmail.com

RUN mkdir -p /var/www/sub \
 && sh -c "echo 'hello' > /var/www/sub/index.html" \
 && mkdir -p /app \
 && sh -c "echo 'cd /var/www && python -m http.server 80' > /app/run.sh" \
 && chmod 755 /app/run.sh

EXPOSE 80
WORKDIR /var/www/
CMD /app/run.sh
