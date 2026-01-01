FROM php:8.2-apache AS build

# curlのみ試しで特定バージョン指定、他は最新をインストール
# curlのバージョンはapt show curlで確認した。とりあえず、何か入れたいときはapt show [パッケージ名]で確認した
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    curl=8.14.1-2+deb13u2 \
    git \
    libonig-dev \
    unzip \
    # ref https://qiita.com/vitway/items/660f9121a9c6afbf1047
    # && docker-php-ext-install mbstring \ qiita見たらとりあえずあったので入れたが、php8.2-apacheでapt show composerしたらrecommendsにはいたがdependsじゃなかったから不要と判断してコメントアウト。
    # 要不要はqiitaとかzenじゃなくてapt showかapt cache dependsで判断する。
    # 上記で判断したら、そもそもapt-get install -y --no-install-recommends composerでよかった。。後で試す。
    # ソフト格納先のインストール使用時のみのインデックスを削除
    && rm -rf /var/lib/apt/lists/*

COPY ./composer.json /var/www/html
# ref https://getcomposer.org/download/
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === 'c8b085408188070d5f52bcfe4ecfbee5f727afa458b2573b8eaaf77b3419b0bf2768dc67c86944da1544f06fa544fd47') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \
    && composer install

COPY ./src/. /var/www/html
ADD ./lib/test_dir_file.tar.gz /data
WORKDIR /var/www/html

FROM php:8.2-apache AS deploy

LABEL version="1.0"
LABEL description="PHP-Apache Laravel Environment"
LABEL maintainer="sakamoto"

COPY --from=build /usr/local/bin/composer /usr/local/bin/composer
COPY --from=build /var/www/html /var/www/html
COPY --from=build /data /data

# Docker内で80番ポート使用を宣言、ローカルから使うにはポートフォワードが必要
EXPOSE 80/tcp

RUN useradd www-user \
    && chown www-user:www-user /var/www/html

USER www-user

# コンテナのメインプロセスとして挙動を統一させたい場合はENTRYPOINTを指定。鍵括弧はシェルを介さずプロセスをPID1で起動したい場合(推奨)
# ENTRYPOINT ["php"]
# CMD ["apache2-foreground"]

# VOLUME ["/var/www/html/storage"]

# 環境変数設定例 変数をレイヤーに残したくない場合はENVで設定するとレイヤー扱いになるのでRUNで変数設定し、削除すること
ENV PATH="${PATH}:/usr/local/custom/bin"

# コンテナに残さないのが以下コマンドだがdocker history コンテナ名すると履歴が平文で残るため--secretかAWSの場合、Secret Managerを使うこと
RUN ADMIN_USER="secretkey" \
    && echo $ADMIN_USER > ./user_name.txt \
    && unset ADMIN_USER

# 最後のステージじゃないと反映されない。FROMで前のレイヤーから引き継がれていないため。
ONBUILD CMD ["echo", "Standard PHP build trigger for ECS migration"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl http://localhost/index.php || exit 1