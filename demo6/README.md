# Demo 6

Demo bazuje na aplikacji [helloflask/flask-examples](https://github.com/helloflask/flask-examples) i [daluisgarcia/flask-modular-arquitecture](https://github.com/daluisgarcia/flask-modular-arquitecture).

## Budowanie obrazu

1. Sprawdźmy jak wyglądają warstwy pliku dockerfile bez zmian `Dockerfile1`
```bash
docker build -f Dockerfile1 -t demo6:1 .
docker history demo6:1
docker images demo6
```

Jakieś niepokojące objawy? A co się dzieje jak edytujemy plik app.py

2. Organizacja zależności i kolejności wykonywania - plik `Dockerfile2`
```bash
docker build -f Dockerfile2 -t demo6:2 .
docker history demo6:2
docker images demo6
```

Czy się coś zmieniło? Czy dalej wszystko się kompiluje jak edytujemy plik Pythona? 

3. Organizacja komend `RUN` - plik `Dockerfile3`
```bash
docker build -f Dockerfile3 -t demo6:3 .
docker history demo6:3
docker images demo6
```

Czy udało się ograniczyć rozmiar obrazu?

4. Próba zmniejszenia rozmiaru obrazu bez konieczności zmiany komend - plik `Dockerfile4`
```bash
docker build -f Dockerfile4 -t demo6:4 .
docker history demo6:4
docker images demo6
```

A czy da się jeszcze mniej??

5. Użycie obrazów alpine - plik `Dockerfile5`
```bash
docker build -f Dockerfile5 -t demo6:5 .
docker history demo6:5
docker images demo6
```

Należałoby jeszcze przepatrzeć instalowane zależności w requirements.txt czy są potrzebne.

## Weryfikacja plików w kontenerze

1. Sprawdźmy przy pomocy narzędzia `dive` co znajduje się w dodanych warstwach.
```
dive demo6:5
```

2. Zniwelujmy najpierw niepotrzebne pliki przy pomocy pliku `.dockerignore`
```
# w normalnym użytkowaniu byłby to katalog .git
.fakegit
.dockerignore
Dockerfile*
Wrazliwa_dokumentacja.md
README.md
restore_secret.sh
```

I zbudujmy nowy obraz
```
docker build -f Dockerfile5 -t demo6:5.1 .
dive demo6:5.1
```

3. BONUS: Dostęp do "usunietego" pliku w obrazie dockerowym - plik Dockerfile6
```bash
docker build -f Dockerfile6 -t demo6:6 .
# Weryfikacja plików w uruchomionym kontenerze
docker run --rm demo6:6 ls -all
docker history demo6:6

# Odzyskujemy sekrety z obrazu
./restore_secret.sh demo6:6
```

[Definicja zmian między warstwami - dokumentacja](https://github.com/moby/moby/blob/master/image/spec/v1.md#creating-an-image-filesystem-changeset)

4. Pozbywamy się naszego "sekretu" z obazu dockera
```bash
docker build -f Dockerfile7 -t demo6:7 .
# Weryfikacja plików w uruchomionym kontenerze
docker run --rm demo6:7 ls -all
docker history demo6:7
dive demo6:7

# Odzyskujemy sekrety z obrazu
./restore_secret.sh demo6:7
```