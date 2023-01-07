# Demo 2

Komendy wykonujemy w folderze `demo2`

## Weryfikacja istniejacego pliku dockerfile

```
hadolint Dockerfile
```

A czy się buduje?

```
docker build .
```

### DL3006

[wiki](https://github.com/hadolint/hadolint/wiki/DL3006)
```
Always tag the version of an image explicitly.
```

Poprawka:
```
FROM ubuntu:jammy
```

### DL3008, DL3009 i DL3015

[wiki DL3008](https://github.com/hadolint/hadolint/wiki/DL3008)
```
Pin versions in apt get install.
```

[wiki DL3009](https://github.com/hadolint/hadolint/wiki/DL3009)
```
Delete the apt-get lists after installing something.
```

[wiki DL3015](https://github.com/hadolint/hadolint/wiki/DL3015)
```
Avoid additional packages by specifying --no-install-recommends.
```

Poprawka
```
RUN apt-get update && apt-get install -y --no-install-recommends vim=2:8.2.3995-1ubuntu2.1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
```

### DL4006

[wiki](https://github.com/hadolint/hadolint/wiki/DL4006)
```
Set the SHELL option -o pipefail before RUN with a pipe in
```

Poprawka

```
#dodać linię po FROM
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
```