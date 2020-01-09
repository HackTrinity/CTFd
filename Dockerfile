FROM python:3.7-alpine


COPY . /opt/CTFd
WORKDIR /opt/CTFd
RUN apk --no-cache add linux-headers libffi-dev gcc make musl-dev mysql-client git openssl-dev && \
    ./requirements.sh && \
    apk --no-cache del linux-headers libffi-dev gcc make musl-dev openssl-dev

VOLUME /var/log/CTFd /var/lib/uploads

EXPOSE 8000/tcp
ENTRYPOINT ["/opt/CTFd/docker-entrypoint.sh"]
