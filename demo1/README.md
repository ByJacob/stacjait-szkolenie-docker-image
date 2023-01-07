# Demo 1

## Pierwszy obraz

Komendy wykonujemy w folderze `demo1/image1`
```
cd image1
```

### Budujemy pierwszy obraz
```
docker build -f Dockerfile -t demo1-1 .
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

Komendy wykonujemy w folderze `demo1/image2` 

### Budujemy pierwszy obraz
```
docker build -f Dockerfile -t demo1-2 .
```

### Weryfikacja warstw zbudowanego obrazu
```
docker history demo1-2
```

### Jak się prezentuje ogólna wielkośc obrazu
```
docker image ls | grep demo1-2
```