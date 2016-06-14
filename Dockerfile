FROM hrektts/ubuntu:16.04.20160525
MAINTAINER mps299792458@gmail.com

ENV NGINX_VERSION 1.10.0-0ubuntu0.16.04.2

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 \
    --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
 && echo "deb http://nginx.org/packages/ubuntu xenial main" \
    > /etc/apt/sources.list.d/nginx-stable-xenial.list \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y nginx=${NGINX_VERSION} \
 && rm -rf /var/lib/apt/lists/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log

ENV DOCKER_GEN_VERSION 0.7.3

RUN wget https://github.com/jwilder/docker-gen/releases/download/${DOCKER_GEN_VERSION}/docker-gen-linux-amd64-${DOCKER_GEN_VERSION}.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-${DOCKER_GEN_VERSION}.tar.gz \
 && rm docker-gen-linux-amd64-${DOCKER_GEN_VERSION}.tar.gz

COPY nginx.tmpl /app/
WORKDIR /app/

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh
COPY cmd.sh /sbin/cmd.sh
RUN chmod 755 /sbin/cmd.sh

ENV DOCKER_HOST unix:///tmp/docker.sock

EXPOSE 80 443
VOLUME ["/etc/nginx/certs"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["/sbin/cmd.sh"]
