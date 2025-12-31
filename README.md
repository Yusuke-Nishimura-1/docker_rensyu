# 概要
- Dockerとphpの学習目的
- Dockerのゴールは、基本的なイメージpullから自力で修正しビルドからRUNもしくはRUN後のエラー内容を確認できるようになること。
- そのために、Dockerベストプラクティス集に則りDockerfileの記載方法をDockerfileに記載した。
- phpのゴールはSREとして最低限のwebアプリ実装できるようにすること。
- そのために、基本文法の習得結果をソースとして記載する。

# 構成
```
.
├── README.md
├── ecs-rensyu　ほぼ使ってない。
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
    ├── lib
    │   └── test_dir_file.tar.gz
    └── src
        ├── help
        │   └── help.php
        └── index.php
```

# dockerビルド&起動コマンド
```
$ docker build -t php-sample ./container/Dockerfile .
$ docker run --rm --name php-sample-c php-sample whoami
$ docker run -itd -p 8080:80 --rm --name php-sample-c php-sample
```
# 実行結果確認
```
$ docker exec -it php-sample bash
```

# php結果参照先
```
http://localhost:8080/help/help.php でブラウザで実行結果確認可能。
```