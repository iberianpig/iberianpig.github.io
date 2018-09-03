---
layout: post
title: "mysqlで特定のテーブルのDumpをのみ取得する"
published: true
date: 2016-01-23
comments: true
categories: Rails
tags: 
  - sql
image: https://i.gyazo.com/1717a969e7fde1fc4f0b2c4ca28de192.png
---

# 必要となった背景
1つのコンテンツに対してそのコンテンツに含まれる複数のカテゴリの組み合わせを元におすすめのコンテンツを表示する。  
動的に表示させようとしたが、現行のままでは動的に出すのは厳しく、バッチ処理でおすすめコンテンツの情報をキャッシュすることにした。  
<!-- more -->
本番環境の裏側で実行させようと考えたが、非常に遅く、1ヶ月ほど時間がかかってしまうため、
一度本番のDumpを取得した上で別の環境でバッチを回し、その結果を本番環境へロードさせたほうが良いということになった。

# テーブル別のDump
いつもDB一括でMySQL workbenchでDumpを取得しているなど、mysqlコマンドに疎い。
今回は他のテーブルは必要なかったので、必要なテーブルのDumpのみを取得する方法を調べた。

下記コマンドでDumpを取得する。複数テーブルの場合は続けてテーブル名を入力すればよい。
また、今回の本番環境、隔離環境はRailsを利用しており、migrationにて既にテーブルが作成されている。  
そのため`-t`オプションにてCREATE TABLE文をスキップさせる

```sh
mysqldump -u <USERNAME> -p -t <DBNAME> <TABLENAME1> [ <TABLENAME2> ... ] > <DUMPFILENAME>.sql
```


# Dumpのインポート

下記コマンドでインポート

```sh
mysqll -u <USERNAME> -p <DBNAME> < <DUMPFILENAME>.sql
```

# seed_fuで入れる場合

[mbleigh/seed-fu](https://github.com/mbleigh/seed-fu) という主に環境整備時に利用するものGemがある。  
テストデータやシードデータの導入の利用される。  
自分は実データをMySQLからdumpしてseed_fu用のfixtureを生成するRakeタスクを作成しており、ユースケースによってはこちらを利用する。

{{< gist iberianpig 0d977156c0474bd3be86bfd73fe7bcc9 >}}

db:dump_seed_fu[model]で実行。 
db:seed_fuで使えるseedデータがdb/fixtures内に生成される。

# Special Thanks

* [ MySQL で特定のテーブルのみをバックアップ - Easy Ramble ](http://easyramble.com/backup-only-mysql-tables.html)
* [mbleigh/seed-fu](https://github.com/mbleigh/seed-fu)  

