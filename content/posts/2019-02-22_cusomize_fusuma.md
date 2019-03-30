---
layout: post
title: "Fusumaのインストールと設定"
draft: false
date: 2019-02-22T23:07:09+09:00
comments: true
tags: 
   - "ruby"
   - "libinput"
categories: "Linux"
image: "https://i.gyazo.com/504267be3d139795a2231eb0f7896df5.png"
description: "Linux上でタッチパッド上のジェスチャーにアクションを定義出来るFusumaのインストール方法やカスタマイズについて説明する"
---

Linux上でタッチパッド上のジェスチャーをカスタマイズ出来るFusumaというライブラリをRubyGems公開している。
日本語の記事もあまりないので、使い方やカスタマイズの記事を書いてみることにした。

<div class="iframely-embed"><div class="iframely-responsive" style="height: 168px; padding-bottom: 0;"><a href="https://github.com/iberianpig/fusuma" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fgithub.com%2Fiberianpig%2Ffusuma&amp;key=f073c4f447189e73167146bd9d0f6195"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>



RubyGemsにライブラリを公開した時の記事⇓

<div class="iframely-embed"><div class="iframely-responsive" style="height: 168px; padding-bottom: 0;"><a href="https://iberianpig.github.io/posts/2017-05-14_multi-touch-on-linux/" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fiberianpig.github.io%2Fposts%2F2017-05-14_multi-touch-on-linux%2F&key=f073c4f447189e73167146bd9d0f6195"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>


# Fusumaのインストール

Debian系を利用しているOS(パッケージ管理にaptを利用している)なら下記の`apt install`等のコマンドはそのまま利用できるはず。

自分はUbuntu16.04ベースのelementary OS lokiをインストールしたDell XPS 13(9360)で利用している。

Archの人はArchWikiに色々書いてもらっているようなのでそちらを参照。  
https://wiki.archlinux.org/index.php/Libinput#fusuma

Ubuntu 15.04以降ではFusumaに依存するlibinputを使用することができるが、Ubuntu 14以下の古いバージョンではsynapticsドライバを使用するxswipe[xSwipe](https://github.com/iberianpig/xSwipe/)を試してみて欲しい。

## インストールされているRubyのバージョンを確認
まず最初にRubyをインストールしてあるか確認。
システムにインストールされているRubyでも問題ない。  
(もちろんrbenvやrvm使ってても問題ない)

```
$ ruby -v

ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-linux]
# ↑Rubyの2.4がインストールされていることを確認
```


## 依存パッケージのインストール

タッチパッドの入力を読ませる必要があるため`libinput-tools`をインストールする。
(Fusuma内部で`libinput debug-events`によるデバッグログの出力を利用している)

```shell
$ sudo apt install libinput-tools
```

また、`Alt+Left`, `Alt+Right`などショートカットを発行できるようにするため`xdotool`をインストールする。

```shell
$ sudo apt install xdotool
```

## FusumaをRubyGemsからインストール

```shell
$ sudo gem i fusuma
```

`i`は`install`の省略。システムのRubyでインストールする場合は`sudo`が必要。

(rbenvやrvmでインストールしているRubyを使う場合、`$ gem i fusuma` でインストール出来る)


## Fusumaの設定ファイルを作成する

`~/.config/fusuma/config.yml`に設定ファイルを作成する。

```shell
$ mkdir -p ~/.config/fusuma
$ touch ~/.config/fusuma/config.yml
```

エディタで`~/.config/fusuma/config.yml`を開き、以下の内容を貼り付ける

```yaml
swipe:
  3:
    left:
      command: 'xdotool key alt+Right'
    right:
      command: 'xdotool key alt+Left'
    up:
      command: 'xdotool key ctrl+t'
    down:
      command: 'xdotool key ctrl+w'
```

↑ 3本指スワイプでブラウザの(戻る/進む/タブを作成/タブを閉じる)ショートカットを登録する例。

## inputグループにユーザーを追加

Fusumaの実行にはタッチパッドの入力を読み取り出来る権限をユーザーに与える必要がある。

```
$ sudo gpasswd -a $USER input
```
`gpasswd`というコマンドを使って`input`グループにユーザーを追加している。(ここの`$USER`は実行時のユーザー名が自動的に指定される)


**ここで必ずXからログアウト・ログイン(もしくは再起動)を行うこと。**

inputグループ追加の反映に必要で、これをやっておかないとfusumaがタッチパッドを認識出来ない。



# Fusumaの起動

ターミナルを開き、fusumaと入力してエンター。

```shell
$ fusuma
```

ブラウザ上での3本指スワイプで`戻る`/`進む`/`タブの作成`/`タブを閉じる`ができていればOK。


## ターミナルを閉じてもバックグラウンドで実行し続けるようにする

```shell
$ fusuma -d
```
この`-d`オプションでdemonize(デーモン化) し、ターミナルプロセスから切り離される。そのためターミナルを閉じても`fusuma`が有効な状態となる


# ジェスチャに割り当てるコマンドを設定する

認識させるジェスチャと割り当てるコマンドを`~/.config/fusuma/config.yml`に追加する。

## ターミナル上で実行するコマンドを確認する
ワークスペースを切り替えるには`xdotool key ctrl+alt+Up`や`xdotool key ctrl+alt+Down`などが正しく動作するかターミナル上で試してみることをおすすめする。
正しく実行出来たコマンドを`~/.config/fusuma/config.yml`に登録する。  
この例のワークスペースのショートカットはWindowManagerに依存する。(Gnome 3はワークスペース切替は`xdotool key ctrl+alt+Up`や`xdotool key ctrl+alt+Down`で上下移動する)

## 4本指スワイプでワークスペースを切り替える

`swipe`セクションの最下部に以下を貼り付ける

```yml
  4:
    up: 
      command: 'xdotool key ctrl+alt+Down'
    down: 
      command: 'xdotool key ctrl+alt+Up'
```

設定ファイルを書き換えた場合は`fusuma`を`Ctrl-c`や`kill`コマンドなどで停止させ`fusuma`コマンドで再実行させる。

カスタマイズした4本指スワイプが反映されていればOK。


# Fusumaの自動起動設定

再起動の度にターミナルを開いてFusumaコマンドを実行するのは面倒なので自動起動するように設定する。


1. ターミナルで`which fusuma`を入力し、Fusumaの起動パスをメモする
2. `gnome-session-properties`を起動し、メモしたパスを入力し末尾に`-d`オプション(デーモン化)を足しておく

# Fusumaのアップデート

```shell
$ sudo gem update fusuma
```

(`rbenv`, `rvm`のRubyを利用してインストールした場合は`gem update fusuma`でOK)


# その他のカスタマイズなど
`~/.config/fusuma/config.yml`上でピンチズーム(`pinch in`/`pinch out`)や各ジェスチャに対しての`threshold`(しきい値)を設定できる。
連続してピンチインするようなジェスチャの設定も可能。

詳細は[FusumaのリポジトリのREADME](https://github.com/iberianpig/fusuma/blob/master/README.md)を参照。

# バグを見つけたら

バグを見つけた場合[Github Issue](https://github.com/iberianpig/fusuma/issues)への登録をお願いしますm(_ _)m

# Patreon
あと、寄付プラットフォームのPatreonはじめた。

<div class="iframely-embed"><div class="iframely-responsive" style="padding-bottom: 40.625%; padding-top: 120px;"><a href="https://www.patreon.com/iberianpig" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fwww.patreon.com%2Fiberianpig&amp;key=f073c4f447189e73167146bd9d0f6195"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

Fusumaのアップデート内容はPatreonに投稿していく。
直近だと、FluentdのようにRubyGemsを利用したプラグインによる機能追加をサポートする予定で、その内容を紹介していきたい。
