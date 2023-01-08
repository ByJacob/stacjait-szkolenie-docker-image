# Demo 3

Komendy wykonujemy w folderze `demo3`

## Budowanie obrazów do weryfikacji

```
docker build -f Dockerfile1 -t demo3-1 .
docker build -f Dockerfile2 -t demo3-2 .
```

### Screeny z analizy zbudowanych obrazów

#### demo3-1

`docker history`

![docker history](demo3-1-1.png "docker history")

`dive`

![dive](demo3-1-2.png "docker history")

#### demo3-2

`docker history`

![docker history](demo3-2-1.png "docker history")

`dive`

![dive](demo3-2-2.png "docker history")