FROM sameersbn/ubuntu:14.04.20150323
MAINTAINER mps299792458@gmail.com

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv C300EE8C \
 && echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu trusty main" \
    > /etc/apt/sources.list.d/nginx-stable-trusty.list \
 && apt-get update \
 && apt-get install -y nginx \
 && rm -rf /var/lib/apt/lists/*

COPY assets/setup/ /app/setup/
RUN chmod 755 /app/setup/install
RUN /app/setup/install

COPY assets/init /app/init
RUN chmod 755 /app/init

EXPOSE 80
EXPOSE 443

VOLUME ["/home/nginx/data"]
VOLUME ["/var/log/nginx"]

ENTRYPOINT ["/app/init"]
CMD ["app:start"]
