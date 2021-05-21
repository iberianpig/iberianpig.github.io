---
layout: post
title: "Fusuma v2の新機能の紹介"
draft: true
date: 2021-04-26T22:05:57+09:00
comments: true
tags: 
   - Linux
   - ruby
   - libinput
image: "https://opengraph.githubassets.com/ecc39c3b5067e737618dce4b17876b2ef6c628c6dbcacd9db938a2a57e8b161c/iberianpig/fusuma"
description: "Fusumaがv2にメジャーアップデートし3本指でのドラッグやAlt+Tab、アプリ固有のジェスチャ設定など新機能が導入された。"
---

Linux向けのマルチタッチジェスチャツールの[Fusuma](https://github.com/iberianpig/fusuma)がv2にバージョンアップした。

<div class="iframely-embed"><div class="iframely-responsive" style="padding-bottom: 50%; padding-top: 120px;"><a href="https://github.com/iberianpig/fusuma" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fgithub.com%2Fiberianpig%2Ffusuma&amp;key=f073c4f447189e73167146bd9d0f6195"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

この記事ではFusumaのv2へのアップデートとv2から使える新機能について紹介する。

# Fusuma v2のアップデートの概要

Fusuma v2ではマルチプロセス化、I/O多重化、contextに応じた設定の切り替えなど、
色々とアップデートが入った結果、以下のような機能が実現できるようになった。

* アプリ固有のジェスチャ設定
* Mac OSの3本指ドラッグ
* Windowsの3本指スワイプによるウィンドウ切り替え(Alt+Tab)
* スワイプ/ローテートによる音量調整・輝度変更


動作確認した環境はUbuntu 20.04(X11/Gnome-shell)。

```
$ fusuma --version
reload config: /home/iberianpig/.config/fusuma/config.yml
---------------------------------------------
Fusuma: 2.0.4
libinput: 1.16.5
ruby 2.7.0p0
OS: Linux 5.6.0-1056-oem #60-Ubuntu SMP Tue May 4 06:40:10 UTC 2021
Distribution: Ubuntu 20.04.2 LTS \n \l
Desktop session: ubuntu x11
---------------------------------------------
```

Fusuma v2から要求するRubyバージョンが2.5.1以上となっているので注意。

# FusumaとFusumaプラグインを最新版にアップデート

gemコマンドでアップデートできる。
システムワイドのRubyを使ってインストールしていない場合`sudo`は不要。

```sh
$ sudo gem update fusuma
```

インストール済みのFusumaプラグインがある場合はそれらをアップデートしておく。

```sh
# プラグインをリストする
$ sudo gem list fusuma-plugin-
fusuma-plugin-keypress (0.4.1)
fusuma-plugin-sendkey (0.6.2)
fusuma-plugin-wmctrl (0.4.3)
```
```sh
# プラグインをアップデート
$ sudo gem update fusuma-plugin-sendkey fusuma-plugin-wmctrl fusuma-plugin-keypress
```



# アプリケーション固有のジェスチャ設定 

Fusuma v2から利用可能な新しいプラグインを作った。
[fusuma-plugin-appmatcher](https://github.com/iberianpig/fusuma-plugin-appmatcher)をインストールすることでFusumaのconfig.yml上でアプリケーション固有の設定ができるようになる。


<div class="iframely-embed"><div class="iframely-responsive" style="padding-bottom: 50%; padding-top: 120px;"><a href="https://github.com/iberianpig/fusuma-plugin-appmatcher/tree/master/lib/fusuma/plugin/appmatcher" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fgithub.com%2Fiberianpig%2Ffusuma-plugin-appmatcher%2Ftree%2Fmaster%2Flib%2Ffusuma%2Fplugin%2Fappmatcher&amp;key=f073c4f447189e73167146bd9d0f6195"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

これまでジェスチャの設定はアプリ関係なくグローバルな設定のみだったので、アプリ毎に微妙にショートカットキーが違う場合も対応できるようになる。

## fusuma-plugin-appmatcherのインストール

ターミナルで↓のコマンドを実行

```
$ sudo gem install fusuma-plugin-appmatcher
```

自分が動作確認できるX11とUbuntu-Waylandは現在サポートしているが、Plasma Waylandや他のWayland環境へは未対応。
コマンドから`wm_class`を取得できさえすれば実装可能なので、[fusuma-plugin-appmatcher](https://github.com/iberianpig/fusuma-plugin-appmatcher)にPull Requestを作ってもらえると嬉しい。


## 設定で利用するアプリケーション名の取得

config.ymlでアプリを指定するためのアプリケーション名は`$ fusuma-appmatcher -l`で取得できる。
`-l`オプション無しの場合はフォアグラウンドのアプリケーション名のみを取得する。

```sh
$ fusuma-appmatcher -l
discord
Slack
Gnome-terminal
Google-chrome
```


## config.ymlに`context: WM_CLASS`を設定する

1. config.ymlの最下部に`---`を追加して`context`を区切る。
1. `context: { application: Google-chrome }`を追加する。
1. その下に`swipe: ...`と通常通りジェスチャを記述していく。


それぞれ異なるアクションをGoogle-chromeとGnome-terminalに対して3本指のスワイプジェスチャに割り当ててみる。

```yml
# デフォルトのコンテキスト
swipe:
  4:
    up:
      workspace: next  # 次のワークスペースに移動
      keypress:
        LEFTSHIFT:
          window: next # ウィンドウを次のワークスペースに移動
    down:
      workspace: prev  # 前のワークスペースに移動
      keypress:
        LEFTSHIFT:
          window: prev # ウィンドウを前のワークスペースに移動

# ↓Contextを区切るために`---`が必要
---

# context: { application: Google-chrome }
# ⇅は同じ意味
context:
  application:  Google-chrome

swipe:
  3:
    left:
      sendkey: 'LEFTALT+RIGHT' # 進む
    right:
      sendkey: 'LEFTALT+LEFT'  # 戻る
    up:
      sendkey: 'LEFTCTRL+T'    # タブを開く
      keypress:
        LEFTSHIFT: # シフトキー押しながら
          sendkey: 'LEFTSHIFT+LEFTCTRL+T' # 最後に閉じたタブを開く
    down:
      sendkey: 'LEFTCTRL+W'    # タブを閉じる
---
context:
  application:  Gnome-terminal

swipe:
  3: 
    up:
      sendkey: 'LEFTSHIFT+LEFTCTRL+T' # タブを開く
    down:
      sendkey: 'LEFTSHIFT+LEFTCTRL+W' # タブを閉じる
```

この例には[fusuma-plugin-wmctrl](https://github.com/iberianpig/fusuma-plugin-wmctrl)、[fusuma-plugin-sendkey](https://github.com/iberianpig/fusuma-plugin-sendkey)、[fusuma-plugin-keypress](https://github.com/iberianpig/fusuma-plugin-keypress)を利用している。

Google ChromeとGnome Terminalでそれぞれ3本指上スワイプを試してみるとどちらもタブが開く。
Google Chromeには`LEFTCTRL+T`、Gnome Terminalには`LEFTSHIFT+LEFTCTRL+T`とそれぞれ異なるキーを割り当てることができた。


Fusuma v2から`---`を含むYAMLドキュメントを処理できるようになった。`---`で区切られた先頭のドキュメントがデフォルトのconfigとなる。
ちなみに`---`は1つのファイル内で複数ドキュメントを記述できるYAML標準のシンタックスである。


# Mac OSの3本指ドラッグをLinuxで実現する

TwitterでMac OSのトラックパッドでの3本指のドラッグ機能が便利らしいことを目にした。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Mac の操作がヌルヌルできない人はこの設定入れておくと良いぞ？ / Mac で最高に便利な「3本指のドラッグ」 - kakakakakku blog <a href="https://t.co/4Un28vU11q">https://t.co/4Un28vU11q</a></p>&mdash; カック@テックブロガー (@kakakakakku) <a href="https://twitter.com/kakakakakku/status/1164903204238135296?ref_src=twsrc%5Etfw">August 23, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


> 「3本指のドラッグ」の用途は無限にあって，具体的な例を挙げておく．Keynote でキレイな発表資料を作るときも使えないと困ってしまう．
> 
> * Chrome で表示されている文字をドラッグしてコピーするとき
> * iTerm2 でターミナルの結果をドラッグしてコピーするとき
> * Keynote でオブジェクトのサイズを変更するとき


とても便利そう。

ということでLinux向けにFusuma上で実装した。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Linuxタッチパッドで3本指ドラッグ <a href="https://t.co/kFNtKGU9x2">pic.twitter.com/kFNtKGU9x2</a></p>&mdash; iberianpig(Kohei Yamada) (@nukumaro22) <a href="https://twitter.com/nukumaro22/status/1364924640125014021?ref_src=twsrc%5Etfw">February 25, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

テキスト選択、Chromeのタブ移動、ウィンドウの移動など、3本指ドラッグは確かに便利。
トラックパッドでクリックしてから別の指でドラッグするよりも、3本指ドラッグは操作ステップが少く直感的に動かせる。

## 3本指ドラッグの設定方法

↓ を`~/.config/fusuma/config.yml`に設定して、Fusumaを再起動すると3本指のドラッグができるようになっている。

```yaml
swipe:
  3:
    begin:
      command: xdotool mousedown 1 # 左マウスボタンを押し続ける
    update:
      command: xdotool mousemove_relative -- $move_x, $move_y # マウス移動
      interval: 0.01 # 更新間隔を小さく
      accel: 2 # マウスの移動量の増加
    end:
      command: xdotool mouseup 1 # 左マウスボタン解放
```


## `begin:`/`update:`/`end:`プロパティ

Fusuma v2からスワイプ、ピンチ、ローテートにジェスチャの`開始`/`更新`/`終了`イベントを割り当てを個別で設定できるようになった。
例えば上述の3本指ドラッグの設定では `begin:`/`update:`/`end:` にxdotoolの `マウス押下`/`マウス移動`/`マウス解放` を割り当ている。

またジェスチャの移動量の`$move_x`, `$move_y`, `$zoom`, `$rotate`が変数として扱えるようにした。
`accel: 2` は`$move_x`, `$move_y`などの値を2倍にする。3本指ドラッグで移動距離を増やすのに使っていて、今の所ほぼ3本指ドラッグ専用の機能。
これらの変数は`command:`に指定されたコマンドから環境変数としてアクセスできる。

実は3本指ドラッグは以前からGithubに機能追加のIssueはあって、実装したかった機能の1つだった。

<div class="iframely-embed"><div class="iframely-responsive" style="padding-bottom: 50%; padding-top: 120px;"><a href="https://github.com/iberianpig/fusuma/pull/224" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fgithub.com%2Fiberianpig%2Ffusuma%2Fpull%2F224&amp;key=f073c4f447189e73167146bd9d0f6195"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

`開始`/`更新`/`終了`イベントに個別のアクションの割当が可能になり、複雑なジェスチャがconfig.ymlで表現できるようになった。
ちなみに後述のAlt+Tabのウィンドウ切り替えやローテートの音量・輝度調節もこの機能で実現している。


# Windowsの3本指スワイプによるウィンドウ切り替え

3本指ドラッグと同じくこの機能も以前から要望があった。
Windowsは3本指の左右スワイプでAlt+Tabショートカットと同様のウィンドウの切り替えができる。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Linuxで3本指スワイプのウィンドウ切り替え <a href="https://t.co/Zr1jBrqCd5">pic.twitter.com/Zr1jBrqCd5</a></p>&mdash; iberianpig(Kohei Yamada) (@nukumaro22) <a href="https://twitter.com/nukumaro22/status/1393227683039903753?ref_src=twsrc%5Etfw">May 14, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

スワイプするとウィンドウを切り替え、指を離すまではプレビューが出る。
Fusuma v2の`begin:`/`update:`/`end:`を利用して実現する。

## Alt+Tabウィンドウ切り替えの設定方法

```yaml
swipe:
  3:
    begin:
      command: xdotool keydown Alt # Altキーを押し続ける
    right:
      update:
        command: xdotool key Tab  # Tabキーを押下
        interval: 5
    left:
      update:
        command: xdotool key Shift+Tab # Shift+Tabキーを押下
        interval: 5
    end:
      command: xdotool keyup Alt  Alt # Altキー解放
```

`Alt`を押しっぱなしにして指が左右へ移動する時に`Tab`/`Shift+Tab`を押下する。
ウィンドウの切り替えが早すぎると使いづらいので`interval: 5`を設定して`update:`のイベントを間引いている。
ちなみに`begin:`/`update:`/`end:`はSwipeやPinch/Rotateの方向プロパティ(`right`/`left`など)の下にも設定できる。


# スワイプ/ローテートによる音量・輝度調整

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Linuxで回転ジェスチャによる音量・輝度調節 <a href="https://t.co/nxGUxFFV9R">pic.twitter.com/nxGUxFFV9R</a></p>&mdash; iberianpig(Kohei Yamada) (@nukumaro22) <a href="https://twitter.com/nukumaro22/status/1393232055383691274?ref_src=twsrc%5Etfw">May 14, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

* 3本指のローテート(回転)ジェスチャで音量が変更できる。Shiftキーを押すと音量変化の幅が小さくなって微調整が効く。
* ALTキーを押しながら回転させると輝度を変更する。

## 音量・輝度調整の設定方法

```yaml
rotate:
  3:
    clockwise: # 時計回り
      update:
        sendkey: VOLUMEUP # 音量UP 
        LEFTSHIFT: # Shift押しながら
          sendkey: LEFTSHIFT+VOLUMEUP # 音量UP(微増)
        LEFTALT: # Alt押しながら
          sendkey: BRIGHTNESSUP # 輝度UP
    counterclockwise:  # 反時計回り
      update:
        sendkey: VOLUMEDOWN # 音量DOWN
        LEFTSHIFT: # Shift押しながら
          sendkey: LEFTSHIFT+VOLUMEDOWN  # 音量DOWN(微減)
        LEFTALT: # Alt押しながら
          sendkey: BRIGHTNESSDOWN  # 輝度DOWN
```

動作確認のために設定してみたら意外と便利なジェスチャだったので紹介してみた。

# その他の設定はWikiへ
Fusumaがv2にメジャーアップデートしてジェスチャの表現の幅が広がった。

今回紹介した設定も[fusuma Wiki](https://github.com/iberianpig/fusuma/wiki)に書いている。
各々のディストリビューションごとの設定なども書かれていて、こちらは誰でも編集できるので便利な設定を見つけたら共有してもらえると嬉しい。
