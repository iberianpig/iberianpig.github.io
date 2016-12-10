---
layout: post
title: "node/npmをUbuntuにインストールする方法"
published: true
date: 2015-08-16
comments: true
categories: javascript
tags:
  - nodejs
  - ubuntu
  - linux 
image: https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Node.js_logo.svg/553px-Node.js_logo.svg.png
---



ionic入れようとした時にwarning出たのでnodeの最新バージョンを入れた。  
sudo apt-get install nodejsで入るバージョンが最新でなかったので少し調べる事になった。

環境はElementary OS freya(Ubuntu14.04ベース)

<!-- more -->

# nodesource.comで管理しているppaを利用

PPAから最新のnodeを入れる。
最初からPPAを登録するのではなく、nodesource.comからインストールスクリプトを落として実行する。

wget入ってない場合はインストール。  
`sudo apt-get install wget`

ppaの導入  
`wget -qO- https://deb.nodesource.com/setup | sudo bash -` を実行  

# nodeのインストール

`sudo apt-get install nodejs`  
nodeではなくnodejsを使う

# version番号の確認

`node -v`  
v0.12.7  

`npm -v`  
2.11.3  

色々やってるようだけど内部ではPPAを追加してるようで、`sudo apt-get update`でアップデートできるようになる
