---
categories: "Linux"
comments: true
date: 2017-06-25T22:48:09+09:00
description: "Linuxデスクトップを利用する際に少し問題になるBIOSのアップデート。
ここではUEFI BIOSに対応したfwupdというツールを使ってアップデートする。"

image: "https://i.gyazo.com/265d5fab5db286263c9c9f46e604a79f.png"
layout: post
published: true
tags:
- ""
title: fwupdでLinuxからUEFI(BIOS)のアップデート
---

Linuxデスクトップを利用する際に少し問題となるBIOSのアップデート。
ここではfwupdというツールを使ってUEFI(BIOS)のアップデート方法を書く。


特徴として、別のデバイスにBootableなディスクを焼いてアップデートする必要がないが、サポートされているデバイスでなければ対応出来ない。

なお、[Unetbootinを使ってUSBデバイスからのアップデート手順](http://qiita.com/iberianpig@github/items/92d6684be74e708203d6)をQiitaに書いているのでそちらもご参考あれ。

この記事はUbuntu16.04ベースのelementary os v0.4(loki), Dell XPS13 9360で試した内容を元にを書いている。

# fwupdで利用可能なデバイスかどうかを確認する

利用可能なデバイスのリストはこちら→(https://fwupd.org/lvfs/devicelist)
自分の[XPS13 9360はfwupdでアップデート可能](https://fwupd.org/lvfs/device/5ffdbc0d-f340-441c-a803-8439c8c0ae10)だった。

# fwupdのインストール

aptでfwupdインストールする

```bash
sudo apt install fwupd
```

# cabファイルをダウンロード

(https://fwupd.org/lvfs/devicelist) からダウンロードする。

[![https://gyazo.com/aea60172de3d87cbaf7c0c8e0ff4a558](https://i.gyazo.com/aea60172de3d87cbaf7c0c8e0ff4a558.png)](https://gyazo.com/aea60172de3d87cbaf7c0c8e0ff4a558)

画像内のリンク先のcabファイル。

# fwupdmgrでインストール

fwupdmgrというコマンドが利用出来るようになっている。

ただし、ACアダプタを接続していないと進めないので注意する。

`fwupdmgr install`でファームウェアをインストール。

```bash
fwupdmgr install /path/to/your/downloaded/firmware.cab
```

これでインストール待ち状態になった。  
再起動時にBIOSのロード画面でアップグレードが走る。

# Special Thanks

* https://github.com/hughsie/fwupd
* https://fwupd.org/lvfs/devicelist

