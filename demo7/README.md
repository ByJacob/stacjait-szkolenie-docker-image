# Demo 7

Komendy wykonujemy w folderze `demo7`

## Budowanie obrazu

1. Spróbujmy budujmy obraz produkcyjny

```
docker build -t demo7:1 .
docker run -it --rm demo7:1 php -v
docker run -it --rm demo7:1 composer --version
docker run -it --rm demo7:1 cat /app/super_remote_config.txt
```

2. Sprawdźmy jak wygląda nasz Dockerfile

3. To teraz może obraz deweloperski?

```
docker build -t demo7:1-dev --target dev-image .
docker run -it --rm demo7:1-dev php -v
docker run -it --rm demo7:1-dev composer --version
docker run -it --rm demo7:1-dev cat /app/super_remote_config.txt
```

4. To teraz potrzebujemy php 7.4, ale z composerem 1 bo mamy strasznie legacy projekt

```
docker build -t demo7:2 --build-arg PHP_VERSION=7.4 --build-arg COMPOSER_VERSION=1 .
docker run -it --rm demo7:2 php -v
docker run -it --rm demo7:2 composer --version
```

No i oczywiście kontener deweloperski
```
docker build -t demo7:2-dev --target dev-image --build-arg PHP_VERSION=7.4 --build-arg COMPOSER_VERSION=1 .
docker run -it --rm demo7:2-dev php -v
docker run -it --rm demo7:2-dev composer --version
```