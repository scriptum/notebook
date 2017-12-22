# Celery usage example

## Prepare

```sh
cd path/to/notebook/python/message_broker_redis
virtualenv .
pip install celery redis
```

## Run celery

`-B` is needed for scheduler.

```sh
./bin/celery worker -B
```

## Run client

```sh
./bin/python caller.py
```
