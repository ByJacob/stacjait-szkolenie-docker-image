# Demo 4

Komendy wykonujemy w folderze `demo4`

## Clair

### Uruchamianie narzędzia Clair

[dokumentacja](https://quay.github.io/clair/howto/testing.html#starting-a-cluster)

Komendy:
```
git clone https://github.com/quay/clair.git
cd clair
git checkout v4.5.1
docker compose up -d
```

Aby zweryfikować czy narzędzie działa można sprawdzić jego logi `docker compose logs -f --tail=10` lub spróbować wejść na stronę [http://localhost:8080](http://localhost:8080)

### Działanie narzędzia Clair

1. Uruchomienie narzędzia [clairctl](https://quay.github.io/clair/howto/getting_started.html#submitting-a-manifest) w istniejącej infrastrukturze
 ```
docker compose exec -w /src/cmd/clairctl indexer go run .
```
2. Uruchomienie testu
```
docker compose exec -e CLAIR_API=http://traefik:6060/ -e CLAIR_CONF=/etc/clair.yaml -w /src/cmd/clairctl indexer go run . -D report ubuntu:jammy
```
3. Weryfikacja innych funkcji
```
docker compose exec -e CLAIR_API=http://traefik:6060/ -e CLAIR_CONF=/etc/clair.yaml -w /src/cmd/clairctl indexer go run . --help
docker compose exec -e CLAIR_API=http://traefik:6060/ -e CLAIR_CONF=/etc/clair.yaml -w /src/cmd/clairctl indexer go run . report --help
```
4. Inne cli dla clair:
    - [jgsqware/clairctl](https://github.com/jgsqware/clairctl)
    - [klar](https://github.com/optiopay/klar)

### Przykładowy wynik raportu Clair

```
ubuntu:jammy found bash               5.1-6ubuntu1             CVE-2022-3715 on Ubuntu 22.04 LTS (jammy) - low.
ubuntu:jammy found coreutils          8.32-4.1ubuntu1          CVE-2016-2781 on Ubuntu 22.04 LTS (jammy) - low.
ubuntu:jammy found gpgv               2.2.27-3ubuntu2.1        CVE-2022-3219 on Ubuntu 22.04 LTS (jammy) - low.
ubuntu:jammy found libc-bin           2.35-0ubuntu3.1          CVE-2016-20013 on Ubuntu 22.04 LTS (jammy) - negligible.
ubuntu:jammy found libc6              2.35-0ubuntu3.1          CVE-2016-20013 on Ubuntu 22.04 LTS (jammy) - negligible.
ubuntu:jammy found libgssapi-krb5-2   1.19.2-2                 CVE-2022-42898 on Ubuntu 22.04 LTS (jammy) - medium.
ubuntu:jammy found libk5crypto3       1.19.2-2                 CVE-2022-42898 on Ubuntu 22.04 LTS (jammy) - medium.
ubuntu:jammy found libkrb5-3          1.19.2-2                 CVE-2022-42898 on Ubuntu 22.04 LTS (jammy) - medium.
ubuntu:jammy found libkrb5support0    1.19.2-2                 CVE-2022-42898 on Ubuntu 22.04 LTS (jammy) - medium.
ubuntu:jammy found libncurses6        6.3-2                    CVE-2022-29458 on Ubuntu 22.04 LTS (jammy) - negligible.
ubuntu:jammy found libncursesw6       6.3-2                    CVE-2022-29458 on Ubuntu 22.04 LTS (jammy) - negligible.
ubuntu:jammy found libpam-modules     1.4.0-11ubuntu2          CVE-2020-36394 on Ubuntu 22.04 LTS (jammy) - low.
ubuntu:jammy found libpam-modules     1.4.0-11ubuntu2          CVE-2022-28321 on Ubuntu 22.04 LTS (jammy) - negligible.
ubuntu:jammy found libpam-modules-bin 1.4.0-11ubuntu2          CVE-2020-36394 on Ubuntu 22.04 LTS (jammy) - low.
ubuntu:jammy found libpam-modules-bin 1.4.0-11ubuntu2          CVE-2022-28321 on Ubuntu 22.04 LTS (jammy) - negligible.
ubuntu:jammy found libpam-runtime     1.4.0-11ubuntu2          CVE-2020-36394 on Ubuntu 22.04 LTS (jammy) - low.
ubuntu:jammy found libpam-runtime     1.4.0-11ubuntu2          CVE-2022-28321 on Ubuntu 22.04 LTS (jammy) - negligible.
ubuntu:jammy found libpam0g           1.4.0-11ubuntu2          CVE-2020-36394 on Ubuntu 22.04 LTS (jammy) - low.
ubuntu:jammy found libpam0g           1.4.0-11ubuntu2          CVE-2022-28321 on Ubuntu 22.04 LTS (jammy) - negligible.
ubuntu:jammy found libpcre3           2:8.39-13ubuntu0.22.04.1 CVE-2017-11164 on Ubuntu 22.04 LTS (jammy) - negligible.
ubuntu:jammy found libssl3            3.0.2-0ubuntu1.7         CVE-2022-3996 on Ubuntu 22.04 LTS (jammy) - low.
ubuntu:jammy found libsystemd0        249.11-0ubuntu3.6        CVE-2022-3821 on Ubuntu 22.04 LTS (jammy) - medium.
ubuntu:jammy found libsystemd0        249.11-0ubuntu3.6        CVE-2022-4415 on Ubuntu 22.04 LTS (jammy) - medium.
ubuntu:jammy found libsystemd0        249.11-0ubuntu3.6        CVE-2022-45873 on Ubuntu 22.04 LTS (jammy) - medium.
ubuntu:jammy found libtasn1-6         4.18.0-4build1           CVE-2021-46848 on Ubuntu 22.04 LTS (jammy) - low.
ubuntu:jammy found libtinfo6          6.3-2                    CVE-2022-29458 on Ubuntu 22.04 LTS (jammy) - negligible.
ubuntu:jammy found libudev1           249.11-0ubuntu3.6        CVE-2022-3821 on Ubuntu 22.04 LTS (jammy) - medium.
ubuntu:jammy found libudev1           249.11-0ubuntu3.6        CVE-2022-4415 on Ubuntu 22.04 LTS (jammy) - medium.
ubuntu:jammy found libudev1           249.11-0ubuntu3.6        CVE-2022-45873 on Ubuntu 22.04 LTS (jammy) - medium.
ubuntu:jammy found ncurses-base       6.3-2                    CVE-2022-29458 on Ubuntu 22.04 LTS (jammy) - negligible.
ubuntu:jammy found ncurses-bin        6.3-2                    CVE-2022-29458 on Ubuntu 22.04 LTS (jammy) - negligible.
ubuntu:jammy found tar                1.34+dfsg-1build3        CVE-2021-20193 on Ubuntu 22.04 LTS (jammy) - low.
```

## Wyłączamy aplikację clair

```
docker compose down -v
```