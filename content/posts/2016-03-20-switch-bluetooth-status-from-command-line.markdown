---
layout: post
title: "Bluetoothのオン・オフをコマンドラインから切り替える"
published: true
date: 2016-03-20
comments: true
tags: 
   - Linux
   - tethering
   - bluetooth
image: https://upload.wikimedia.org/wikipedia/commons/f/fc/BluetoothLogo.svg
---


以前、ブログで書いたAndroidのテザリング用アプリ、Easytether。
[EasytetherでBluetoothテザリング](https://iberianpig.dev/posts/2015-06-07-easytether%E3%82%92linux%E3%81%A7%E4%BD%BF%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B/)

端末はXperia Z1f(Docomo)を使っていて、MVMOのSIMに切り替えた際に機器デフォルトのテザリング機能が利用できなくなってしまった。
EasytetherではBluetooth, USBテザリングが選択できるが、こちらはMVMOのSIMを利用しても問題なくテザリングできる。

# Easytether使う前にBluetoothを有効にする

Easytetherを使う際にはAndroid側のBluetooth,EasyTetherを立ち上げてBluetoothテザリングを有効にし、そのあとPC側でBluetoothをパネルから有効にし、
コマンドラインで`easytether-bluetooth connect -d MAC_ADDRESS`と入力する必要がある。

結構面倒なのだ。喫茶店に来るたびにこれをやったり、携帯もって少し離れるとBluetoothは切れてしまうので、また再接続するのがダルい。
ということで以前のブログでEasyTether用にショートカットキーを割り当てたのだが、Bluetooth自体のオン、オフはまだ出来ていなかった。

<!--more-->

# コマンドラインで自動化する

少し調べてうまく行ったので、メモ。


```sh
# bluetooth off
sudo hciconfig hci0 down

# bluetooth on
sudo hciconfig hci0 up
```

これだけ。

ちなみに追記後はこちら

```
#!/bin/sh

pgrep -lf easytether
ret=$?

if test ${ret} -eq 0
then
  pkill easytether -f
  sudo hciconfig hci0 down
else
  sudo hciconfig hci0 up
  sudo easytether-bluetooth MAC_ADDRESS
fi
```

ちなみに別の起動時の省電力スクリプトの中にも`sudo hciconfig hci0 down`を追加した。
起動時はbluetoothをオフにする設定。

NFCで携帯近づけてWifi、テザリングのON/OFFまで出来たらベストなんだけれども。
(SONYのNFCタッチでBluetooth接続するUXがかなり良かったので）
