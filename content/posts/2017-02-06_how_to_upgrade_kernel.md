---
categories: "Linux"
comments: true
date: 2017-02-06T17:53:41+09:00
description: "カーネルバージョン4.4ではディスプレイ周りの不具合が多かったため、カーネルバージョンを4.8までアップグレードした。"
image: "https://i.gyazo.com/f14af56a0f8f5f8f3fcbf8e5f90f71f9.png"
layout: post
published: true
tags: 
  - "Ubuntu"
  - "kernel"

title: "Ubuntuのベースバージョンを変えずにLinuxカーネルをアップグレードする方法"
---

環境のElementary OS 0.4 Lokiを利用しているが、カーネルのバージョンは4.4である。
4.4ではディスプレイ周りの不具合が多かったため、カーネルをアップグレードしたかった。
本記事の内容は、基本的にベースバージョンのUbuntu16.04でも同様と見てもらって構わない。

# ukuuによるカーネルのアップグレード

`ukuu`というツールを使えば任意のkernelをインストール出来る

リポジトリを追加する

```bash
sudo apt-add-repository -y ppa:teejee2008/ppa
```

ukuuのインストール

```bash
sudo apt update && sudo apt install ukuu
```

Ukuu Kernel Update Utilityというアプリを選択して起動(`ukuu`でターミナルから起動してもいい)

![ukuuのUI](https://i.gyazo.com/f14af56a0f8f5f8f3fcbf8e5f90f71f9.png)

カーネルのバージョンを選んでインストール出来る。インストールされたカーネルはローカルにキャッシュされていて、
キャッシュ済の場合バージョンを簡単に切り替えできる。

記事執筆時点では4.9.8までインストール出来ることを確認した。
動作確認時に特に問題はないと思われたが、[Fusuma](https://github.com/iberianpig/fusuma)が依存している`libinput-debug-events`のログにエラーが出ていた。
そのため`ukuu`によるアップグレードではなく、後述するHWEカーネル用パッケージをインストールすることにした。

# HWEカーネル用パッケージのインストール


HWEカーネルとは

> HWE（Hardware Enablement）カーネルは，より新しいハードウェアでもLTSを使えるように用意されている
> 「LTS Enablement Stacks」のカーネルです。
> 簡単に言うと，LTS以降にリリースされたUbuntuで使われるカーネルを，LTSでも使えるようにしたものです。
(http://gihyo.jp/admin/serial/01/ubuntu-recipe/0278) より引用

安定版と開発版があり、開発版であれば4.8が入るそうだったので開発版をインストールすることにした。

linux-generic-hwe-16.04-edgeをインストール

```bash
sudo apt install linux-generic-hwe-16.04-edge
```

バージョンの確認
```bash
$ uname -a

Linux XPS-L321X 4.8.0-34-generic #36~16.04.1-Ubuntu SMP Wed Dec 21 18:55:08 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
```

カーネルバージョンは4.8.0-34まで上がった。
ハードウエアのサポートが入っているためか、こちらでは`libinput-debug-events`が正しく動作していた。

# Special Thanks

* How to Easily Upgrade Ubuntu’s Linux Kernel With Ukuu
 (http://www.makeuseof.com/tag/upgrade-kernel-ukuu-ubuntu/)

* Ubuntu Weekly Recipe 第278回 Ubuntuカーネルとの付き合い方
 (http://gihyo.jp/admin/serial/01/ubuntu-recipe/0278)

* Ubuntu 16.04 その113 - ローリングLTS Enablement Stackモデルの採用へ
 (http://kledgeb.blogspot.jp/2016/11/ubuntu-1604-113-lts-enablement-stack.html)

* Package: linux-generic-hwe-16.04-edge (4.8.0.34.6)
 (http://packages.ubuntu.com/xenial/kernel/linux-generic-hwe-16.04-edge)
