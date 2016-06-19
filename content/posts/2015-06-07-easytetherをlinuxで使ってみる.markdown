---
layout: post
title: "EasytetherでBluetoothテザリング"
published: true
date: 2015-06-07
comments: true
tags: linux, easytether, tethering
categories: linux easytether tethering
image: https://i.ytimg.com/vi/GjL3HTeVnbY/hqdefault.jpg
---

# Easytether with linux

[![EasytetherFull](https://lh6.ggpht.com/SkGhbKqXHvu3P08ZU_hW2ezWnTGOYEBjNvPp0cDBhWzAlBYlhoG6xS45-BVv0hSraA=w300-rw)](https://play.google.com/store/apps/details?id=com.mstream.easytether_polyclef&hl=ja)  
[EasytetherFull( GooglePlay )](https://play.google.com/store/apps/details?id=com.mstream.easytether_polyclef&hl=ja)


数年前に、AndroidのXperia acroHD使ってた時に利用してた有償のテザリングアプリ。一応FreeのLite版もある。  
そして、公式の**Linux向けクライアント**がある。  
当時はUSBテザリングで利用しており、テザリングサポート外の端末でも動作して、そこそこ速度が出ていたので利用していた。  
Linux版パッケージは[ こちら ](http://www.mobile-stream.com/easytether/drivers.html) からダウンロード可。  

現在利用しているXperia Z1fではUSBテザリング、Wifiテザリング、Bluetoothは標準でサポートされている。  
いつもはXperia側のバッテリーの事を気にかけてBluetoothでテザリングを行っていたが、Easytetherの事だから標準より速度出るのでは…?と、気になってみたのでやってみた

<!-- more -->

## Speedテスト3回戦  

|Easytether Bluetoothテザリング| AndroidのBluetoothテザリング|
|:----------------------------:|:----------------------:|
| <a href="http://www.speedtest.net/my-result/4414894284"><img src="http://www.speedtest.net/result/4414894284.png" /></a> | <a href="http://www.speedtest.net/my-result/4414914824"><img src="http://www.speedtest.net/result/4414914824.png" /></a>
| <a href="http://www.speedtest.net/my-result/4414923094"><img src="http://www.speedtest.net/result/4414923094.png" /></a> | <a href="http://www.speedtest.net/my-result/4414920048"><img src="http://www.speedtest.net/result/4414920048.png" /></a>
| <a href="http://www.speedtest.net/my-result/4414925130"><img src="http://www.speedtest.net/result/4414925130.png" /></a> | <a href="http://www.speedtest.net/my-result/4414927464"><img src="http://www.speedtest.net/result/4414927464.png" /></a>

## やはり、Easytetherの方が早い。

若干だけれども。
ただ、バッテリー消費量の検証は行っていないので片手落ち感はある。
ただし起動/終了が面倒なので、ショートカット割り当てまで行う。

# おまけ(起動スクリプトの登録)

## 接続を切り替えるscriptを作る

easytether.shを任意のディレクトリに作成。  

```sh
#!/bin/sh

pgrep -lf easytether
ret=$?

if test ${ret} -eq 0
then
  # 既に起動中の場合停止させる
  pkill easytether -f
else
  # 対象のスマホのBluetoothのMACアドレスを指定して接続
  sudo easytether-bluetooth BT:MA:CA:DD:RE:SS
fi
```
内容はこんな感じ。  

実行権与えたいので`sudo chmod +x easytether.sh`してあげる

`sudo ./easytether.sh`で動かしてみる。

## パスワードの省略( sudoersの変更 )

ただし、sudo つけてあげないとEasytetherが動いてくれないので、自動化やショートカット割り当てはには向かない。そこで下記のように`sudo visudo`で当該スクリプトに関してはパスワードが必要ない旨を明示し、パスワードを省略する。  

```
<username> ALL=(ALL) NOPASSWD: /path/to/script/
```
## xbindkeysショートカットキーのマッピング

xbindkeysを利用してマッピングする。  
持ってない人は`sudo apt-get install xbindkeys`で入れましょう。便利。

`~/.xbindkeysrc`に下記を追記する

```
"sudo /path/to/script/easytether.sh"
   Mod4 + F2
```
これはSuper_L + F2で起動させるようにした。  
これでEasytetherの切り替えがショートカットのみで行われるようになった。  

色々なキーを自作のスクリプトにバインドしてるけれど、xbindkeys便利すぎる。  


それではEasytetherで良いノマドライフを!  
