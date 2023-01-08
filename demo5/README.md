# Demo 5

Komendy wykonujemy w folderze `demo5`

## s6-overlay

Przygotowania infrastruktura jest dla narzędzia w wersji 3. Narzędzie w wersji 2 obsługowało zupełnie inną strukturę plików.

[Dokumentacja](https://github.com/just-containers/s6-overlay)

### Dodawanie serwisu

1. Konfiguracja s6 znajduje się w katalogu `/etc/s6-overlay/s6-rc.d`
2. Tworzymy w nim katalog dla naszej aplikacji, w naszym przypadku jest to `mynginx`
3. Ustawiamy typ serwisu poprzez utworzenie pliku `type` z zawartością. W naszym przypadku jest to `longrun`
4. Definiujemy komendę do uruchomienia dla naszej aplikacji w pliku `run`. W przykładzie używamy powłoki [execline](https://skarnet.org/software/execline/index.html). Jednak równie dobrze można użyć `/bin/sh` lub `/bin/bash` jeżeli jest dostępny. Należy jedynie zwrócić uwagę na [dostępność zmiennych systemowych](https://github.com/just-containers/s6-overlay#container-environment)
5. Należy "zarejestrować" naszą usługę dla narzędzia s6-overlay. Aby to zrobić należy w folderze `/etc/s6-overlay/s6-rc.d/user/contents.d/` utworzyć pusty plik z nazwą aplikacji. W naszym przypadku jest to `mynginx`
6. Dodatkowo musimy zadbać, ze nasza usługa uruchomi się po całkowitej inicjalizacji. Aby to zrobić tworzymy folder `dependencies.d` z pustym plikiem `base`

### Czas na testy naszej aplikacji :)

1. Najpierw budujemy obraz: `docker build -t demo5 .`
2. Teraz uruchamiamy z otwartym portem: `docker run --name c-demo5 -p 8080:80 -d demo5`
3. Sprawdźmy logi kontenera: `docker logs -f c-demo5`
4. A teraz czy nasz kontener właściwie działa: [localhost:8080](http://localhost:8080/)
5. Koniec tych testów: `docker rm -f c-demo5`

### Edycja strony początkowej nginxa - dodajemy inicjatora

1. Ponownie dodajeky konfigurację w katalogu `/etc/s6-overlay/s6-rc.d`
2. Tworzymy katalog `mypage` w folderze s6-rc.d
3. Definiujemy typ serwisu na `oneshot` poprzez plik `type`
4. Definiujemy akcje jaka się ma wykonwać. Tym razem użyjemy powłoki bash z zdefiniowanymi zmiennymi w pliku `run`.
```bash
#!/command/with-contenv sh

cat > /var/www/html/index.html <<DELIM
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>Demo5 - Jak skutecznie zaprojektować i wytworzyć dobry obraz dockerowy</title>
<style>
body {
background-color: red;
text-align: center;
color: yellow;
font-family: Arial, Helvetica, sans-serif;
}
</style>
</head>
<body>
<img src="https://stacja.it/wp-content/themes/stacjait/assets/logos/logo-stacjait-white@2x.png" alt="Stacja.it"><br>
<h1>Jestem $MY_USER i świetnie się bawie na tym warsztacie!!!</h1>
</body>
</html>
DELIM
```
5. Niestety serwis typu `oneshot` nie obsługuje bezpośrednio zawartości pliku `run`. Konfigurację definuje się w pliku `up`. Niestety plik ten domyślnie ma powłokę `execline`, jednak nic nie stoi na przeszkodzie wywołanie skryptu /bin/sh przy pomocy tej powłoki.
```bash
/etc/s6-overlay/s6-rc.d/mypage/run
```
6. Definiujemy główną zależność jako `base`
7. Dodajemy do serwisu `mynginx` zależność `mypage` w postaci pustego pliku

### I kolejne testy

1. Najpierw budujemy obraz: `docker build -t demo5 .`
2. Teraz uruchamiamy z otwartym portem: `docker run -e MY_USER=$USER --name c-demo5 -p 8080:80 -d demo5`
3. Sprawdźmy logi kontenera: `docker logs -f c-demo5`
4. A teraz czy nasz kontener właściwie działa: [localhost:8080](http://localhost:8080/)
5. Aby zmienić wyświetlanego użytkownika wystarczy zmienić wartość dla zmiennej MY_USER
```bash
docker rm -f c-demo5 && docker run -e MY_USER=superadmin --name c-demo5 -p 8080:80 -d demo5
```
6. Koniec tych testów: `docker rm -f c-demo5`