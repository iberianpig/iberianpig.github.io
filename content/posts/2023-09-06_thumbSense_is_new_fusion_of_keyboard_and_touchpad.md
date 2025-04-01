---
layout: post
title: "キーボードとタッチパッドをシームレスに統合するThumbSense"
draft: false
date: 2023-09-06T09:19:50+09:00
lastmod: 2023-09-06T09:19:50+09:00
comments: true
tags:
  - ruby
  - linux
  - libinput
image: "https://i.gyazo.com/f1287b6c6ef727356b43ded17601e651.png"
description: "タッチパッドとキーボードをシームレスに統合するThumbSenseをLinux向けに実装した"
---

## ThumbSenseとは？

ThumbSenseは、タッチパッドとキーボードをシームレスに統合することで、操作感を向上させる革新的なソフトウェア。
ユーザーは指（親指）がタッチパッドに触れているかを基準に仮想キーボードのレイヤーが自動的に切り替わり、キーボードをマウスボタンのように利用できる。
タッチパッドとキーボード間の移動が最小限に抑えられ、スムーズな操作が可能になる。
![thumbsense](https://i.gyazo.com/cf929775aec1e3aefaabb3a6dd15a3ff.gif)


## ThumbSenseの革新的なアプローチ


- ThumbSenseは、2003年にSony CSLの暦本氏がWindows向けに開発したソフトウェア(https://www2.sonycsl.co.jp/person/rekimoto/tsense/soft/index.html)
    - タッチパッドに触れているかどうかに基づいてキーボードのレイヤーを自動的に切り替えを行うことで、キーボードのキーをマウスボタンとして使用できるようになり、操作の移動を最小限に抑えることでキーボードとタッチパッド間のシームレスな操作が可能となる


- オリジナルが発表されてから20年経っているが、この間のRubyKaigi 2023でLinux向けのThumbSenseをリリースした
  - タッチパッドジェスチャ認識アプリのFusumaのプラグインとして実装されている(https://github.com/iberianpig/fusuma-plugin-thumbsense)
  - RubyKaigi2023の記事(https://iberianpig.dev/posts/2023-05-17_rubykaigi2023/)   


## タッチパッドとキーボードを一つのデバイスとして扱う

ThumbSenseは指（親指）がタッチパッドに触れているかどうかで、特定のキーがマウスボタンとして機能するか、通常のキーボードキーとして機能するかを切り替える。

 ![RubyKaigiのスライドの一部](https://i.gyazo.com/a40aab93a88e7233473352024a70bf8b.png)

ThumbSenseを使用すると、同じ指でポインタを移動し、クリックする際の操作感が大きく変わる。具体的には、以下のステップで操作が行われる。
1. 指でタッチパッドにふれる(親指でも、どちらかの指をホームポジションからずらしてもよい)
2. FキーやJキーを使ってクリック。

タッチパッドのクリックボタンの操作に近いが、キーボード上のホームポジションにある指を使えることにメリットがあり、シングルタップによるクリック操作と比べて移動とクリックの操作が分離されるため、通常のタッチパッド操作よりスムーズな操作感が得られる。

また、Thumbsense利用時はtap to clickというタッチパッド上のシングルタップでクリックする機能をオフにすることをオススメする。
タップではなくF/Jにクリック操作を任せるためなのだが、副次的に文字入力中にカーソルが意図せず飛ぶ誤爆が防げるようになるメリットがある。
ちなみにlibinputやsyclientにDisable-while-typingという入力中のタップ操作を防止したり、手のひら検知して除外する機能が存在するが、それだけで完全に誤入力が防げるわけではないので、オフにしたほうが体験が良い。

## インストールと設定方法

ThumbSenseを利用するには、以下の手順で設定を行う。

### 必要なパッケージのインストール

```sh
$ sudo apt install libinput-tools libevdev-dev 

# rbenvなどでrubyをインストールしている場合は以下は不要
$ sudo apt install ruby-dev build-essential
```

次に、fusuma-plugin-thumbsenseをインストールする。

```sh
# rbenvなどでrubyをインストールしている場合はsudoは不要
$ sudo gem install fusuma-plugin-thumbsense
```

次にudevの設定を行う。これらはキーボードのリマップを行うために必要な設定。

### udevの設定

udevの設定を行い、キーボードのリマッピングに必要な設定を追加する。

```sh
$ sudo gpasswd -a $USER input # inputグループに$USERを追加 (一度ログアウトして再ログインする必要がある)
$ echo 'KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/60-udev-fusuma-remap.rules 
$ sudo udevadm control --reload-rules && sudo udevadm trigger # udevの設定を反映
```

**ユーザーがinputグループに所属していない場合はここで一度ログアウトして再ログインする必要があるため注意**

### 設定ファイルの作成

設定ファイル~/.config/fusuma/config.ymlを以下のように書く。

```yaml
---

context:
  thumbsense: true

remap:
  F: BTN_LEFT
  E: BTN_MIDDLE
  D: BTN_RIGHT
  J: BTN_LEFT
  K: BTN_RIGHT
```

その後、以下のコマンドでfusumaを起動する。

```sh
$ fusuma
```

fusuma実行後はタッチ中にFキーを押すと左クリック、Dキーを押すと右クリック、Eキーを押すとホイールクリックができるようになる。

また、これは実際にやってみないと便利さがなかなか伝わらないのだが、マルチタッチジェスチャと組み合わせが便利。

![Dragging and Swipe gesture with Fusuma](https://i.gyazo.com/b434e5c33712b210ea58650451c21caf.gif)
Fキーでのドラッグアンドドロップ中に、スワイプジェスチャを挟んで隣の仮想デスクトップにドロップしたりできる。

## Fusumaとの統合と今後

Fusumaは、Linux上でマルチタッチジェスチャーをサポートするためのツールで、スワイプ/ピンチ/タップなどのジェスチャーをコマンドやキー送信に割当できる。

<div class="iframely-embed"><div class="iframely-responsive" style="height: 168px; padding-bottom: 0;"><a href="https://github.com/iberianpig/fusuma" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fgithub.com%2Fiberianpig%2Ffusuma&amp;key=f073c4f447189e73167146bd9d0f6195"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>


今回のThumbsenseの実装でFusumaに仮想キーボードや仮想タッチパッドの実装が整ってきた(fusuma-plugin-remapが実装できた)ので、XやWaylandに依存しないデバイスイベントの処理ができるようになった。

これまでできなかったキーリマッパー実装やタッチパッドのパームリジェクション、2本指スワイプ実装などを進めていく予定。



