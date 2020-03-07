FROM python:3.7-alpine

WORKDIR /opt/CTFd
COPY requirements.txt /opt/CTFd/
RUN apk --no-cache add linux-headers libffi-dev gcc make musl-dev mysql-client git openssl-dev libxml2 libxml2-dev \
        libxslt libxslt-dev && \
    pip install -r requirements.txt && \
    apk --no-cache del linux-headers libffi-dev gcc make musl-dev openssl-dev libxml2-dev libxslt-dev

COPY . /opt/CTFd

RUN apk --no-cache add su-exec && \
    addgroup -S ctfd && \
    adduser -SDH -G ctfd ctfd && \
    install -dD -o ctfd -g ctfd /var/log/CTFd /var/lib/CTFd/uploads
VOLUME /var/log/CTFd /var/lib/CTFd/uploads

EXPOSE 8000/tcp
ENTRYPOINT ["/opt/CTFd/docker-entrypoint.sh"]
