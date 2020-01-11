FROM python:3.7-alpine

WORKDIR /opt/CTFd
COPY requirements.txt requirements.sh CTFd/plugins/*/requirements.txt /opt/CTFd/
RUN apk --no-cache add linux-headers libffi-dev gcc make musl-dev mysql-client git openssl-dev mariadb-connector-c \
    mariadb-dev && \
    ./requirements.sh && \
    apk --no-cache del linux-headers libffi-dev gcc make musl-dev openssl-dev mariadb-dev

COPY . /opt/CTFd
VOLUME /var/log/CTFd /var/lib/uploads

EXPOSE 8000/tcp
ENTRYPOINT ["/opt/CTFd/docker-entrypoint.sh"]
