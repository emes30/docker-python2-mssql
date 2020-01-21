FROM debian:8-slim

LABEL maintainer="Michał Sobczak <michal@sobczak.tech>"

COPY ./dev.pack /tmp/dev.pack

COPY ./requirements.txt /tmp/requirements.txt

RUN apt-get update && apt-get -y install curl

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/8/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get -y install apt-transport-https && \
    apt-get update && \
    apt-get -y install python python-pip && \
    pip install --upgrade "pip==19.2.3" "setuptools<45" && \
    hash pip && \
    apt-get -y install python-dev build-essential && \
    ACCEPT_EULA=Y apt-get -y install unixodbc unixodbc-dev msodbcsql17 && \
    pip install --no-cache-dir -r /tmp/requirements.txt && \
    apt-get -y remove --purge `cat /tmp/dev.pack`

COPY openssl.cnf /etc/ssl/
