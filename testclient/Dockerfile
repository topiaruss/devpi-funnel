FROM python:3
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -q \
    && apt-get install -y python-pip \
    && apt-get install -y netcat \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
ADD testclient/requirements.txt /
RUN pip install -r requirements.txt
ADD testclient/tests /


