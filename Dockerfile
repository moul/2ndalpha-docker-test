FROM ubuntu:14.04

RUN df -h

ADD puppet/Puppetfile /
ADD puppet /puppet

RUN apt-get -y update
RUN apt-get -y install librarian-puppet supervisor
RUN apt-get -y -q install wget git-core

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN librarian-puppet install
RUN puppet apply --debug --verbose --modulepath=/modules /puppet/manifests/main.pp

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 80

CMD ["/usr/bin/supervisord"]