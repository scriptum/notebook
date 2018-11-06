# Simplest Flask python example

## Prepare

1. Install docker and docker-compose: `dnf install -y docker docker-compose`
1. Add user into docker group: `sudo usermod -aG docker myusername`
1. Relogin
1. Start docker service if needed: `systemctl start docker.service`

## Run server

```sh
docker-compose up --build
```

## Check

```sh
curl http://localhost:5000/100000
# ... really big number
ab -c100 -n5000 http://localhost:5000/10
# ~8k rps with uwsgi
```
