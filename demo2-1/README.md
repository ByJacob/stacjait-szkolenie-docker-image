# Demo 2-1

## Weryfikacja istniejacego pliku dockerfile

```
hadolint Dockerfile
```

### DL3006

[wiki](https://github.com/hadolint/hadolint/wiki/DL3006)
```
Always tag the version of an image explicitly.
```

Poprawka:
```
FROM hello-world:linux
```