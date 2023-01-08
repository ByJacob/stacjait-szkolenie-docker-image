# Demo 1

Komendy wykonujemy w folderze `demo1`

## Pierwszy obraz

### Budujemy pierwszy obraz
```
docker build -f Dockerfile1 -t demo1-1 .
```

### Weryfikacja warstw zbudowanego obrazu
```
docker history demo1-1
```

### A może ogólny obraz jest mniejszy?
```
docker image ls | grep demo1-1
```

## Drugi obraz

### Budujemy pierwszy obraz
```
docker build -f Dockerfile2 -t demo1-2 .
```

### Weryfikacja warstw zbudowanego obrazu
```
docker history demo1-2
```

### Jak się prezentuje ogólna wielkośc obrazu
```
docker image ls | grep demo1-2
```