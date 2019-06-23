---
comments: true
date: 2017-03-26T10:21:35+09:00
description: ""
image: ""
layout: post
published: false
tags:
- ""
title: "Ansibleで環境構築 on Ubuntu16.04"
---

Ansibleをインストールする手順及び基礎的な設定方法を説明します。

# 記事を書くきっかけ

* 業務のPJで必要になったこと
* 新しいLinuxマシンに移行時の初期設定を自動化したい

上記を期に学習してしまおうと考えた

現在の環境はElementaryOS Loki 0.4(Ubuntu Base version 16.04.1/Kernel4.8.0)

```
$ uname -a
Linux XPS-L321X 4.8.0-34-generic #36~16.04.1-Ubuntu SMP Wed Dec 21 18:55:08 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
```

現行マシンはDell XPS 13 (L321X, Early 2012) → XPS 13（9360、Late 2016)に移行予定。


# インストール

Python製のツールのため、インストールはpipでも可能だが、Aptパッケージとしても提供されている。

aptでインストールする
```
$sudo apt install ansible
```


バージョン確認
```
$ ansible --version
ansible 2.0.0.2
  config file = /etc/ansible/ansible.cfg
  configured module search path = Default w/o overrides
```


