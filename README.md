# 概要
- Dockerとphpの学習目的
- Dockerのゴールは、基本的なイメージpullから自力で修正しビルドからRUNもしくはRUN後のエラー内容を確認できるようになること。
- そのために、Dockerベストプラクティス集に則りDockerfileの記載方法をDockerfileに記載した。
- phpのゴールはSREとして最低限のwebアプリ実装できるようにすること。
- そのために、基本文法の習得結果をソースとして記載する。

# 構成
```
docker_rensyu
├── README.md
├── ecs-rensyu
│   ├── Dockerfile
│   └── Gemfile
└── php-web-app
    ├── aws
    │   └── network.tf
    ├── composer.json
    ├── container
    │   ├── Dockerfile
    │   ├── Dockerfile.onbuild
    │   └── Dockerfile.sigle
    ├── docker-compose.yml
    ├── lib
    │   └── test_dir_file.tar.gz
    └── src
        ├── help
        │   └── help.php
        └── index.php
```

# dockerビルド&起動コマンド
```
# 作業場所
$ cd ./php-web-app

# ビルド
$ docker build -t php-sample -f ./container/Dockerfile .

# Dockerfile挙動確認
$ docker run -itd -p 8080:80 --rm --name php-sample-c php-sample

# Dockerfile USER確認
$ docker run --rm --name php-sample-c php-sample whoami

# PHP動作確認
$ docker run -itd -p 8080:80 --rm --name php-sample-c -v $(pwd)/src:/var/www/html php-sample
```

# docker compose起動&停止
```
# 起動
$ docker compose up -d

# 停止
$ docker compose down --rmi all
```

# 実行結果確認
```
# dockerコマンドで起動した場合
$ docker exec -it php-sample bash

# docker composeで起動した場合
$ docker exec -it php-web-app-web-app-1 bash
$ docker exec -it php-web-app-db-1 bash
```

# php結果参照先
```
# 実行結果
http://localhost:8080/

# 基本文法
http://localhost:8080/help/help.php でブラウザで実行結果確認可能。
```