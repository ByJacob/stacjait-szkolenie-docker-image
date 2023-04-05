# Demo 8

Komendy wykonujemy w folderze `demo8`

## Budowanie dockera w dockerze bez dockera

Użyjemy plików z demo6

1. Najpierw musimy uruchomić repozytorium, gdzie będą przechowywane obrazy
```
docker run -d -p 5000:5000 --restart=always --name demo7-registry registry:2
```

2. Budowanie przy użyciu narzędzia [img](https://github.com/genuinetools/img)

```
docker run --rm -it \
    --name img \
    --volume $(pwd)/../demo6:/home/user/src:ro \
    --volume $(pwd):/build \
    --workdir /home/user/src \
    --security-opt seccomp=unconfined --security-opt apparmor=unconfined \
    --network host \
    --entrypoint sh \
    r.j3ss.co/img -c 'img build -f Dockerfile7 -t demo8:img . && img save -d demo8:img -o /build/demo8_img.tar'

docker load --input demo8_img.tar
```

3. Budowanie przy użyciu narzędzia [kaniko](https://github.com/GoogleContainerTools/kaniko)
```
docker run \
    -v $(pwd)/../demo6:/workspace \
    --network host \
    gcr.io/kaniko-project/executor:v1.9.2 \
    --dockerfile /workspace/Dockerfile7 \
    --destination "localhost:5000/demo8:kaniko" \
    --context dir:///workspace/
```

4. A teraz porównajmy te obrazy:

```
docker pull localhost:5000/demo8:kaniko
docker history demo6:7 | head
docker history demo8:img | head
docker history localhost:5000/demo8:kaniko | head

docker images demo6:7
docker images demo8:img
docker images localhost:5000/demo8:kaniko
```

5. Wyłączamy dockera z naszym repozytorium
```
docker rm -f demo7-registry
```