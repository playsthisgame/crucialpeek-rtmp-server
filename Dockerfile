FROM ubuntu:latest

# install dependencies
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y git build-essential ffmpeg libpcre3 libpcre3-dev libssl-dev zlib1g-dev wget net-tools

# install rtmp module
RUN git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git

# install and config nginx
RUN wget http://nginx.org/download/nginx-1.21.6.tar.gz && \
    tar -xf nginx-1.21.6.tar.gz && \
    cd nginx-1.21.6 && \
    ./configure --prefix=/usr/local/nginx --with-http_ssl_module --add-module=../nginx-rtmp-module && \
    make -j 1 && \
    make install 

# add nginx.conf and log files
RUN mkdir /var/log/nginx && \
    touch /var/log/nginx/access.log && \
    touch /var/log/nginx/error.log && \
    rm /usr/local/nginx/conf/nginx.conf
COPY conf /usr/local/nginx/conf

# start nginx
RUN /usr/local/nginx/sbin/nginx

EXPOSE 1935