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
├── ecs-rensyu　ほぼ使ってない。
│   ├── Dockerfile
│   └── Gemfile
└── php-web-app
    ├── aws　ECSで構築するときが来たら最低限使えるように作成した。直接は使用しない。
    │   └── network.tf
    ├── composer.json
    ├── container
    │   ├── Dockerfile
    │   ├── Dockerfile.onbuild
    │   └── Dockerfile.sigle
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

# 実行結果確認
```
$ docker exec -it php-sample bash
```

# php結果参照先
```
# 実行結果
http://localhost:8080/

# 基本文法
http://localhost:8080/help/help.php でブラウザで実行結果確認可能。
```