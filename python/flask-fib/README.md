# Simplest Flask python example

## Prepare

```sh
cd path/to/notebook/python/flask-fib
virtualenv .
./bin/pip install -r requirements.txt
```

## Run server

```sh
# for debugging
FLASK_DEBUG=True ./bin/python fib.py
# server on port 8000 with debugging, serving localhost only
HOST=127.0.0.1 PORT=8000 FLASK_DEBUG=True ./bin/python fib.py
# server
./bin/uwsgi uwsgi.ini
```

## Test

```sh
curl http://localhost:5000/100000
# ... really big number
ab -c100 -n5000 http://127.0.0.1:5000/10
# ~2k rps with uwsgi
```
