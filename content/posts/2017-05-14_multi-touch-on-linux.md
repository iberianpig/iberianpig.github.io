---
categories: "linux"
comments: true
date: 2017-05-14T17:27:59+09:00
description: "FusumaというGemを公開した。Linux上のタッチパッドでのジェスチャをキーイベントにマッピングし、スワイプを検知したらワークスペースを移動させるなどの処理を可能にする。"
image: "https://camo.githubusercontent.com/97640cbbff96a8545119e063ffdeb31954d3f739/68747470733a2f2f692e6779617a6f2e636f6d2f37353766656635323633313062396436386636386538306562316534353430662e706e67"
layout: post
published: true
tags:
- "ruby"
title: "Linuxでマルチタッチのジェスチャにショートカットを割り当てるFusumaというGemを作った"
---

linuxのマルチタッチのジェスチャを認識して任意のスクリプトを実行するプログラムを作った。

https://github.com/iberianpig/fusuma

Fusumaという名前でRubyGemsに公開した。

Linux上のタッチパッドでのジェスチャをキーイベントにマッピングし、スワイプを検知したらワークスペースを移動させるなどの処理を可能にする。

ちなみにsyncapticsドライバ向けのPerlでの先行実装の[xSwipe](https://github.com/iberianpig/xswipe) を過去に作っていて、こちらを元にRubyでlibinputドライバ向けに書き直している。

ワークスペースの切り替えする横スワイプが襖を開ける動作と似てるところが由来。

TouchEggやGinsなどUbuntuのWikiに紹介されるようなライブラリは利用するのに一癖ある。そして設定で上手くいかないケースが多い。  
Perl製のxSwipe/今回公開したRuby製のFusumaはデバッグログを利用してタッチパッドの出力を読み取り、任意のスクリプトを発行出来る。そのため、タッチパッドのデバッグログ出力さえ出来ればジェスチャ解釈はできるためマルチタッチジェスチャの敷居がかなり低くなった。


# Fusumaの使い方
インストールについては、fusumaのインストール方法(https://github.com/iberianpig/fusuma#installation) を読んで欲しい。  
**Input Groupにログインユーザ追加後、ログイン・ログアウトしないとFusuma実行ユーザーからタッチパッドが読み取れず、Fusumaが失敗してしまうので注意。**

`fusuma`コマンドで起動。 

`~/.config/fusuma/config.yml`に設定ファイルを配置するとfusuma起動時に読み込んでくれる。

ジェスチャとそれに対応するスクリプトを自由にカスタマイズできる。

下記は一例。
```
swipe:
  3:
    left:
      command: 'xdotool key alt+Right'
    right:
      command: 'xdotool key alt+Left'
    up:
      command: 'xdotool key alt+t'
    down:
      command: 'xdotool key alt+w'
  4:
    left:
      command: 'xdotool key super'
    right:
      command: 'xdotool key super+a'
    up:
      command: 'sh ~/tool/linux/script/desktop_switcher.sh 1'
    down:
      command: 'sh ~/tool/linux/script/desktop_switcher.sh -1'
pinch:
  2:
    in:
      command: 'xdotool key ctrl+equal'
    out:
      command: 'xdotool key ctrl+minus'
  4:
    in:
      command: 'xdotool key super+a'
    out:
      command: 'xdotool key super+s'

threshold:
  swipe: 0.1
  pinch: 0.5

interval:
  swipe: 0.5
  pinch: 0.3
```


 こちらがオプション。

```
Usage: fusuma [options]
    -c, --config=path/to/file        Use an alternative config file
    -d, --daemon                     Daemonize process
    -l, --list-devices               List available devices
        --device="Device name"       Open the given device only
    -v, --verbose                    Show details about the results of running fusuma
        --version                    Show fusuma version
```



自動起動する場合は`gnome-session-properties`等に登録。パスはターミナル上で`$(which fusuma)` で確認。


# Fusumaがタッチパッド上のジェスチャを読み取る仕組み

libinputをデバッグするコマンド`libinput-debug-events`を叩き、画面をスワイプすると下記のようなログが出力される。

```md
event10 GESTURE_SWIPE_BEGIN  +4.28s     3
event10 GESTURE_SWIPE_UPDATE  +4.28s    3  6.47/ 1.35 (13.12/ 2.73 unaccelerated)
event10 GESTURE_SWIPE_UPDATE  +4.29s    3  7.52/ 1.02 (16.13/ 2.19 unaccelerated)
event10 GESTURE_SWIPE_UPDATE  +4.30s    3 11.73/ 0.36 (18.04/ 0.55 unaccelerated)
event10 GESTURE_SWIPE_UPDATE  +4.32s    3 12.90/-0.36 (19.41/-0.55 unaccelerated)
event10 GESTURE_SWIPE_UPDATE  +4.33s    3 16.09/-1.32 (23.24/-1.91 unaccelerated)
event10 GESTURE_SWIPE_UPDATE  +4.35s    3 17.56/-1.97 (24.33/-2.73 unaccelerated)
event10 GESTURE_SWIPE_UPDATE  +4.36s    3 19.34/-2.24 (25.97/-3.01 unaccelerated)
event10 GESTURE_SWIPE_UPDATE  +4.39s    3 21.85/-4.54 (27.61/-5.74 unaccelerated)
event10 GESTURE_SWIPE_UPDATE  +4.41s    3 23.18/-3.94 (28.98/-4.92 unaccelerated)
event10 GESTURE_SWIPE_UPDATE  +4.43s    3 24.93/-5.69 (31.17/-7.11 unaccelerated)
event10 GESTURE_SWIPE_UPDATE  +4.45s    3 26.25/-5.69 (32.81/-7.11 unaccelerated)
event10 GESTURE_SWIPE_UPDATE  +4.46s    3 23.40/-5.47 (29.25/-6.84 unaccelerated)
event10 GESTURE_SWIPE_UPDATE  +4.48s    3 22.09/-6.12 (27.61/-7.66 unaccelerated)
event10 GESTURE_SWIPE_UPDATE  +4.49s    3 19.25/-5.69 (24.06/-7.11 unaccelerated)
event10 GESTURE_SWIPE_UPDATE  +4.50s    3 14.65/-4.81 (18.32/-6.01 unaccelerated)
event10 GESTURE_SWIPE_UPDATE  +4.52s    3 12.47/-4.59 (15.58/-5.74 unaccelerated)
event10 GESTURE_SWIPE_END  +4.58s       3
event10 GESTURE_SWIPE_BEGIN  +5.40s     4
event10 GESTURE_SWIPE_UPDATE  +5.40s    4  4.02/ 0.46 ( 9.02/ 1.03 unaccelerated)
event10 GESTURE_SWIPE_UPDATE  +5.41s    4  6.75/ 0.00 (14.35/ 0.00 unaccelerated)
event10 GESTURE_SWIPE_UPDATE  +5.41s    4 12.68/-0.53 (19.48/-0.82 unaccelerated)
```

このログを取り込んでパースすることで単位時間あたりの移動距離、つまり速さを出すことが出来る。

`距離 ÷時間 = 速さ`

速さが一定のしきい値を超えたらスクリプトを実行している。

# ショートカットの発行
当初は発行がショートカットのみだったが、xdotool等の利用が難しくなったため、出力はconfig.ymlに記述した任意のスクリプトを実行するようにしている。
今後はxdotoolが利用できないWayland環境でのデスクトップ操作を提供する予定。

# その他

はじめてのGemの作成と公開だったので学びが大きかった。
* Bundlerでテンプレが作れる。Bundlerすごい。
* ディレクトリ構成が分かるようになるのでGemを読めるようになった。
* 英語でちゃんとREADME書くとIssue/PRのやり取りが起こる。
* しかしREADMEを読まない人が多い。
* シングルトンクラスを書いてみた。ログ生成と設定の読み込みあたり。
* [オブジェクト指向設計実践ガイド　～Rubyでわかる 進化しつづける柔軟なアプリケーションの育て方](https://www.amazon.co.jp/dp/B01L8SEVYI/ref=dp-kindle-redirect?_encoding=UTF8&btkr=1)を参考にスワイプやピンチズームのベクトルクラスをダックタイプで書いてみた。
* Lint駆動開発が良かった。Rubocopに怒られながら書くと自然と綺麗な書き方になる。
* Hacker NewsのTopに出てる時があって、この時はGitHubのスターが3分に1つくらいのペースでついてた。

# 参考URL
* https://github.com/iberianpig/fusuma
* https://github.com/iberianpig/xswipe
