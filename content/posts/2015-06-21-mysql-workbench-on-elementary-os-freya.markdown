---
layout: post
title: "MySQL WorkbenchでQueryの結果が表示されない問題"
published: true
date: 2015-06-21
comments: true
tags: 
    - mysql
    - elementaryOS
    - ubuntu
categories: Linux
image: https://c1.staticflickr.com/4/3913/14522157584_42fff58cfc_z.jpg
---

elementaryOS freya(Ubuntu14.04ベース)で問題が起きた。  
MySQLはUbuntuのリポジトリにあるものでも依存関係で問題は合ったり、直接Oracleから落としても上手く動かないことも合ったりしたのであまり驚かない。
(またお前か程度)
しかしながら毎度踏みまくるので、ブログなりに記録していかないと、再度環境構築した際に面倒なのでメモ書き。  

<!-- more -->

具体的には以下のような症状。  
[![Gyazo](http://i.gyazo.com/62032b7e85ee9a16a4b33dfb096b1454.png)](http://gyazo.com/62032b7e85ee9a16a4b33dfb096b1454)
workbencだQueryの結果が白くなって表示されない。  
selectした結果がセルで表示されるはずなんだけど。 
ちなみにCUIでMySQLからselectしたりした場合は全く問題ない。  

## 調査してみた
色々な人が死んでた  
workbenchはelementaryOS freya,Ubuntu14.04以降でSQLの実行結果が表示されないバグがあることが報告されている  

また、[ debパッケージの中身を書き換える方法 ](http://askubuntu.com/a/458646)が提案されていたが筆者の環境では失敗。

## source落としてパッチ当ててmakeする(成功)

唯一上手く行った方法。

### 下記コマンドを実行

```bash
sudo apt-get remove mysql-workbench*
tar xvf mysql-workbench-community-6.3.3-src.tar.gz
cd mysql-workbench-community-6.3.3-src
wget -O patch-glib.diff http://bugs.mysql.com/file.php?id=21874&bug_id=74147
patch -p0 < patch-glib.diff
sudo apt-get build-dep mysql-workbench
sudo apt-get install libgdal-dev
cd build
cmake .. -DBUILD_CONFIG=mysql_release
make
sudo make install
```

buildは1.5h程度は見込んでおいた方が良い。  
`sudo make install`後にrebootするときちんとresultが表示される。

## special thanks

* [ reddit ](https://www.reddit.com/r/elementaryos/comments/2tahgl/elementary_mysql_workbench_libglib_242_empty/)
* [ launchpad ](https://bugs.launchpad.net/ubuntu/+source/mysql-workbench/+bug/1376154/comments/7)

