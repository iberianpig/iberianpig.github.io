---
layout: post
title: "Upgrade to elementary OS 5.0 Juno"
draft: true
date: 2019-05-14T15:38:04+09:00
comments: true
tags: 
   - ""
image: ""
description: "elementary OSをアップグレードした際のメモ"
---

# マシンスペック
- Dell XPS 13 9360


# アプリケーションのインストール
## apt

## snap

# 手動で入れたもの

dropbox https://www.dropbox.com/ja/install-linux




# Ansibleでローカル環境の再構築に備える

`ansible-playbook`コマンドでリポジトリの追加、パッケージインストールを行う
```
ansible-playbook ~/.config/ansible/playbook.yml -K
```

playbook.yml
```
```

# fstabの設定
cacheまわり

# grubの設定

# hibernateオプションの設定

https://iberianpig.github.io/posts/2015-05-04-elementary-os-freya%E3%81%A7%E3%83%8F%E3%82%A4%E3%83%90%E3%83%8D%E3%83%BC%E3%83%88%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%92%E8%BF%BD%E5%8A%A0%E3%81%99%E3%82%8B/
の設定では上手くいかずにハマった
https://petit-noise.net/blog/hibernation-on-ubuntu-18-04/
