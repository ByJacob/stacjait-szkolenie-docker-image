# Jak skutecznie zaprojektować i wytworzyć dobry obraz dockerowy

1. Klonujemy to repozytorium do folderu
```
git clone https://github.com/ByJacob/stacjait-szkolenie-docker-image.git
```

2. Pobieramy wymagane obrazy

``` bash
docker pull alpine:3
docker pull ubuntu:22.10
docker pull ubuntu:jammy
docker pull docker.io/library/postgres:12
docker pull quay.io/projectquay/golang:1.17
docker pull docker.io/library/traefik:v2.2
docker pull python:3.10-bullseye
docker pull python:3.10-slim-bullseye
docker pull python:3.10-alpine
docker pull php:8.1
docker pull php:7.4
docker pull registry:2
docker pull r.j3ss.co/img
docker pull gcr.io/kaniko-project/executor:v1.9.2
```

3. Otwieramy sklonowany folder w naszym ulubionym IDE

4. Słuchamy co ma nam prowadzocy do przekazania

## Spis treści
[Demo 1](demo1/README.md)
[Demo 2](demo2/README.md)
[Demo 3](demo3/README.md)
[Demo 4](demo4/README.md)
[Demo 5](demo5/README.md)
[Demo 6](demo6/README.md)
[Demo 7](demo7/README.md)
[Demo 8](demo8/README.md)