FROM python:alpine

WORKDIR /usr/src/app

COPY requirements.txt .

# binary dependencies for gmp
RUN apk add --no-cache gmp mpc1

# build dependencies for gmp
RUN apk add --no-cache --virtual=.build_dependencies \
    musl-dev gcc gmp-dev mpfr-dev mpc1-dev linux-headers && \
    pip install --no-cache-dir -r requirements.txt  && \
    apk del .build_dependencies

COPY app .

EXPOSE 5000

WORKDIR /usr/src/app

CMD [ "uwsgi", "uwsgi.ini" ]
