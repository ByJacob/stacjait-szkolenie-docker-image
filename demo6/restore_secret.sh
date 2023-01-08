#!/bin/bash

# $1 - image name

if [ $# -eq 0 ]; then
  echo "Nie podano obrazu bazowego"
  echo "$0 image_name"
  exit 1
fi

file_name=$(echo $1 | tr ':' '-')
archive_name=$file_name.tar
restore_folder=${file_name}_restore

echo "**************************************"
echo "Pakujemy obraz dockera do archiwum"
echo "**************************************"
rm -rf $archive_name
docker save $1 > $archive_name

echo "Co znajduje się w spakowanym archiwum?"
echo "**************************************"
echo "...."
tar tf $archive_name | head -n 10
echo "...."
echo "Ilość plików: $(tar tf $archive_name | wc -l)"
echo "**************************************"

rm -rf $restore_folder
mkdir -p $restore_folder
tar -xf $archive_name -C $restore_folder

echo "A teraz poszukajmy plików z secretami"
echo "**************************************"
restore_secrets_folder=${file_name}_secrets
rm -rf $restore_secrets_folder
mkdir -p $restore_secrets_folder
COUNTER=1
for f in $restore_folder/*/layer.tar
do 
  if tar tf $f | grep super_tajny_sekret.txt > /dev/null; then
    mkdir -p $restore_secrets_folder/$COUNTER
    tar -xvf $f -C $restore_secrets_folder/$COUNTER $(tar tf $f | grep super_tajny_sekret.txt)
    echo "-> Znaleziono $COUNTER plik"
    COUNTER=$(( COUNTER + 1 ))
  fi
done

if [ "$COUNTER" -gt "1" ]; then
  echo "Znalezione pliku znajdują sie w katalogu $restore_secrets_folder"
  find $restore_secrets_folder -type f | xargs -I {} bash -c "echo -e \"\n\n***Zawartość pliku {}***\n\" && cat {}"
else
  echo "Nie znaleziono żadnych plików z secretami :C"
fi
echo "**************************************"
rm -rf $archive_name
rm -rf $restore_folder