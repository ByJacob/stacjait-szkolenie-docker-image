# Demo 4

Komendy wykonujemy w folderze `demo4`

## Clair

### Uruchamianie narzędzia Clair

[dokumentacja](https://quay.github.io/clair/howto/testing.html#starting-a-cluster)

Komendy:
```
git clone git@github.com:quay/clair.git
cd clair
docker-compose up -d
```

Aby zweryfikować czy narzędzie działa można sprawdzić jego logi `docker-compose logs -f --tail=10` lub spróbować wejść na stronę [http://localhost:8080](http://localhost:8080)

### Działanie narzędzia Clair

1. Uruchomienie narzędzia [clairctl](https://quay.github.io/clair/howto/getting_started.html#submitting-a-manifest) w istniejącej infrastrukturze
 ```
docker-compose exec -w /src/cmd/clairctl indexer go run .
```
2. Uruchomienie testu
```
docker-compose exec -e CLAIR_API=http://traefik:6060/ -e CLAIR_CONF=/etc/clair.yaml -w /src/cmd/clairctl indexer go run . -D report ubuntu:jammy
```
3. Weryfikacja innych funkcji
```
docker-compose exec -e CLAIR_API=http://traefik:6060/ -e CLAIR_CONF=/etc/clair.yaml -w /src/cmd/clairctl indexer go run . --help
docker-compose exec -e CLAIR_API=http://traefik:6060/ -e CLAIR_CONF=/etc/clair.yaml -w /src/cmd/clairctl indexer go run . report --help
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

## docker scan

Wymaga posiadania lokalnie funkcji [docker scan](https://github.com/docker/scan-cli-plugin) i bycia zalogowanym w CLI do [hub.docker.com](https://hub.docker.com/). Poniższą część można wykonać samemu, jednak nie jest to wymagane.

### Uruchomienie skanowania
```
docker scan ubuntu:jammy
# akceptacja narzędzia firm trzecich
Docker Scan relies upon access to Snyk, a third party provider, do you consent to proceed using Snyk? (y/N)
y
```

### Przykładowy raport docker scan

```
Testing ubuntu:jammy...

✗ Low severity vulnerability found in pcre3/libpcre3
  Description: Uncontrolled Recursion
  Info: https://security.snyk.io/vuln/SNYK-UBUNTU2204-PCRE3-2799820
  Introduced through: pcre3/libpcre3@2:8.39-13ubuntu0.22.04.1, grep@3.7-1build1
  From: pcre3/libpcre3@2:8.39-13ubuntu0.22.04.1
  From: grep@3.7-1build1 > pcre3/libpcre3@2:8.39-13ubuntu0.22.04.1

✗ Low severity vulnerability found in openssl/libssl3
  Description: Improper Locking
  Info: https://security.snyk.io/vuln/SNYK-UBUNTU2204-OPENSSL-3167951
  Introduced through: openssl/libssl3@3.0.2-0ubuntu1.7, adduser@3.118ubuntu5
  From: openssl/libssl3@3.0.2-0ubuntu1.7
  From: adduser@3.118ubuntu5 > shadow/passwd@1:4.8.1-2ubuntu2.1 > pam/libpam-modules@1.4.0-11ubuntu2 > libnsl/libnsl2@1.3.0-2build2 > libtirpc/libtirpc3@1.3.2-2ubuntu0.1 > krb5/libgssapi-krb5-2@1.19.2-2 > krb5/libkrb5-3@1.19.2-2 > openssl/libssl3@3.0.2-0ubuntu1.7

✗ Low severity vulnerability found in ncurses/libtinfo6
  Description: Out-of-bounds Read
  Info: https://security.snyk.io/vuln/SNYK-UBUNTU2204-NCURSES-2801048
  Introduced through: ncurses/libtinfo6@6.3-2, bash@5.1-6ubuntu1, ncurses/libncurses6@6.3-2, ncurses/libncursesw6@6.3-2, ncurses/ncurses-bin@6.3-2, procps@2:3.3.17-6ubuntu2, util-linux@2.37.2-4ubuntu3, ncurses/ncurses-base@6.3-2
  From: ncurses/libtinfo6@6.3-2
  From: bash@5.1-6ubuntu1 > ncurses/libtinfo6@6.3-2
  From: ncurses/libncurses6@6.3-2 > ncurses/libtinfo6@6.3-2
  and 10 more...

✗ Low severity vulnerability found in krb5/libkrb5support0
  Description: Integer Overflow or Wraparound
  Info: https://security.snyk.io/vuln/SNYK-UBUNTU2204-KRB5-2797765
  Introduced through: krb5/libkrb5support0@1.19.2-2, adduser@3.118ubuntu5, krb5/libk5crypto3@1.19.2-2, krb5/libkrb5-3@1.19.2-2, krb5/libgssapi-krb5-2@1.19.2-2
  From: krb5/libkrb5support0@1.19.2-2
  From: adduser@3.118ubuntu5 > shadow/passwd@1:4.8.1-2ubuntu2.1 > pam/libpam-modules@1.4.0-11ubuntu2 > libnsl/libnsl2@1.3.0-2build2 > libtirpc/libtirpc3@1.3.2-2ubuntu0.1 > krb5/libgssapi-krb5-2@1.19.2-2 > krb5/libkrb5support0@1.19.2-2
  From: adduser@3.118ubuntu5 > shadow/passwd@1:4.8.1-2ubuntu2.1 > pam/libpam-modules@1.4.0-11ubuntu2 > libnsl/libnsl2@1.3.0-2build2 > libtirpc/libtirpc3@1.3.2-2ubuntu0.1 > krb5/libgssapi-krb5-2@1.19.2-2 > krb5/libk5crypto3@1.19.2-2 > krb5/libkrb5support0@1.19.2-2
  and 8 more...

✗ Low severity vulnerability found in gnupg2/gpgv
  Description: CVE-2022-3219
  Info: https://security.snyk.io/vuln/SNYK-UBUNTU2204-GNUPG2-3035409
  Introduced through: gnupg2/gpgv@2.2.27-3ubuntu2.1, apt@2.4.8
  From: gnupg2/gpgv@2.2.27-3ubuntu2.1
  From: apt@2.4.8 > gnupg2/gpgv@2.2.27-3ubuntu2.1

✗ Low severity vulnerability found in glibc/libc-bin
  Description: Allocation of Resources Without Limits or Throttling
  Info: https://security.snyk.io/vuln/SNYK-UBUNTU2204-GLIBC-2801292
  Introduced through: glibc/libc-bin@2.35-0ubuntu3.1, meta-common-packages@meta
  From: glibc/libc-bin@2.35-0ubuntu3.1
  From: meta-common-packages@meta > glibc/libc6@2.35-0ubuntu3.1

✗ Low severity vulnerability found in coreutils
  Description: Improper Input Validation
  Info: https://security.snyk.io/vuln/SNYK-UBUNTU2204-COREUTILS-2801226
  Introduced through: coreutils@8.32-4.1ubuntu1
  From: coreutils@8.32-4.1ubuntu1

✗ Low severity vulnerability found in bash
  Description: Out-of-Bounds
  Info: https://security.snyk.io/vuln/SNYK-UBUNTU2204-BASH-3098342
  Introduced through: bash@5.1-6ubuntu1
  From: bash@5.1-6ubuntu1

✗ Medium severity vulnerability found in systemd/libsystemd0
  Description: Off-by-one Error
  Info: https://security.snyk.io/vuln/SNYK-UBUNTU2204-SYSTEMD-3098846
  Introduced through: systemd/libsystemd0@249.11-0ubuntu3.6, apt@2.4.8, procps/libprocps8@2:3.3.17-6ubuntu2, util-linux@2.37.2-4ubuntu3, util-linux/bsdutils@1:2.37.2-4ubuntu3, systemd/libudev1@249.11-0ubuntu3.6
  From: systemd/libsystemd0@249.11-0ubuntu3.6
  From: apt@2.4.8 > systemd/libsystemd0@249.11-0ubuntu3.6
  From: procps/libprocps8@2:3.3.17-6ubuntu2 > systemd/libsystemd0@249.11-0ubuntu3.6
  and 6 more...



Package manager:   deb
Project name:      docker-image|ubuntu
Docker image:      ubuntu:jammy
Platform:          linux/amd64
Base image:        ubuntu:22.04

Tested 102 dependencies for known vulnerabilities, found 9 vulnerabilities.

Base Image    Vulnerabilities  Severity
ubuntu:22.04  9                0 critical, 0 high, 1 medium, 8 low

Recommendations for base image upgrade:

Minor upgrades
Base Image      Vulnerabilities  Severity
ubuntu:rolling  6                0 critical, 0 high, 1 medium, 5 low


For more free scans that keep your images secure, sign up to Snyk at https://dockr.ly/ABCDEFG
```

## Porównanie znalezionych podatności

| Clair          | docker scan (snyk) |
|----------------|--------------------|
| CVE-2016-20013 | CVE-2016-20013     |
| CVE-2016-2781  | CVE-2016-2781      |
| CVE-2017-11164 | CVE-2017-11164     |
|                | CVE-2018-5709      |
| CVE-2020-36394 |                    |
| CVE-2021-20193 |                    |
| CVE-2021-46848 |                    |
| CVE-2022-28321 |                    |
| CVE-2022-29458 | CVE-2022-29458     |
| CVE-2022-3219  | CVE-2022-3219      |
| CVE-2022-3715  | CVE-2022-3715      |
| CVE-2022-3821  | CVE-2022-3821      |
| CVE-2022-3996  | CVE-2022-3996      |
| CVE-2022-42898 |                    |
| CVE-2022-4415  |                    |
| CVE-2022-45873 |                    |