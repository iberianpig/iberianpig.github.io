---
layout: post
title: "elementary OS freyaへのアップグレード時のメモ（elementaryOS lunaから）"
published: true
date: 2015-08-15
comments: false
tags: linux, elementaryOS, luna, freya
categories: linux elementaryOS luna freya
image: https://i.ytimg.com/vi/r4s7lk3GVrk/hqdefault.jpg
---

* lunaからのアップグレードはアップデートマネージャなどのGUIでは提供されていない
* 新たにインストールディスクを作成し、上書きでのインストールを行う。(むしろこの方法を推奨していた)
* lunaのインストール時に`/home`と`/`パーティションを分けて管理していたので、`/home`を残して`/`をすべて入れ替える。
* `/home`と`/`(root)パーティションがGparted上で /dev/sda1, /dev/sda2等、どれに割り当てられるかを確認
  * (install時にこれらを割り当てするときに間違えなようにメモしておく)
* elementaryOS freyaのイメージをダウンロード(https://elementary.io)
* UnetbootInでのインストールディスクを作成(今回は8GBのUSBメモリに作成)
* 起動時にBIOS画面でF8を押してUSBディスクからブートさせる。Install elementaryOSを選択

<!-- more -->

# パッケージのインストール

## 各種レポジトリの追加

``` bash
sudo man add-apt-repository
sudo add-apt-repository ppa:mpstark/elementary-tweaks-daily
sudo add-apt-repository ppa:numix/ppa
sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update && sudo apt-get upgrade
sudo add-apt-repository -y ppa:aguignard/ppa
sudo add-apt-repository -y ppa:pi-rho/dev
sudo add-apt-repository -y ppa:git-core/ppa
```


## elementary-tweaks のインストール

アイコンやフォント、アニメーションなどの外観の設定やドッグの設定ができる  

```
sudo apt-get install elementary-tweaks
```


## numixのiconセットのインストール

```
sudo apt-get install numix-*
```
numix-circleを適用


## Arc-themeのインストール

```sh
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_15.04/ /' >> /etc/apt/sources.list.d/arc-theme.list"
wget http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_15.04/Release.key
sudo apt-key add - < Release.key
sudo apt-get update
sudo apt-get install arc-theme
```


## ターミナルの分割にbyobuを利用

```
sudo apt-get install byobu tmux
```


## xclipのインストール
byobu(tmux)上での擬似viコピーにxclipを利用しているので下記を実行  

```
sudo apt-get install xclip
```


## vim-gnomeを入れることでterminal上のvimもクリップボード連携したコピペが可能に。
```
sudo apt-get install vim-gnome
```


## ag のインストール(高速なgrep)

```
sudo apt-get install silversearcher-ag
```


## アプリケーションの設定用アプリケーション(dconf-editor, gconf-editor)

```
sudo apt-get install dconf-editor gconf-editor
```


## gitのインストール
```
sudo apt-get install git tig
```


## GUIパッケージマネージャ
```
sudo apt-get install synaptic
```


## プロセス用のgrep
```
sudo apt-get install pgrep
```

## パスワードマネージャ
```
sudo apt-get install keepassx
```

## システムモニタ(shift+ctrl+ESCにバインドさせる）
```
sudo apt-get install gnome-system-monitor
```

## dropboxのinstall

* websiteからdebパッケージをインストール(https://www.dropbox.com/)
* `dropbox filestatus`で状態/動作の確認


## xSwipeのインストール(マルチタッチジェスチャ)

* インストールはこちらのREADME参照(https://github.com/iberianpig/xSwipe)  
  * 14.04系からsynapticsドライバがアップデートされて依存していたコマンドが利用できなくなったため、 Fork版のドライバを入れる必要あり
* Pull request歓迎。


## fcitx+mozcのインストール

```
sudo apt-get install fcitx fcitx-mozc
```
日本語入力系統をIbusからFcitxへ変更を行うため、`im-config`を実行し、fcitxへ変更する

## dotfiles(.bashrcや.vimrcなど)の設定ファイル
* 自分のGitHubレポジトリから引っ張ってくる
* home直下にdotfiles内からシンボリックリンク張るスクリプトを実行

## 自作スクリプトの実行などにキーバインドを割り当て

``` bash
sudo apt-get install xbindkeys
sudo apt-get install xdotool
```

* dotfilesより.xbindkeysをセット
  * テザリング用の接続コマンド
  * セカンドモニタの位置変更(大体いつも真上にセットする)
  * workspace移動のキーバインドの追加

## 業務用(個人的に必要だったのでメモ)

```
sudo apt-get install mysql-client-5.6
sudo apt-get install mysql-client
sudo apt-get install mysql-server
sudo apt-get install nodejs
sudo apt-get install redis-server
```
__[ workbenchは14.04版にバグがあるため注意](http://askubuntu.com/a/458646)__



適宜アップデートしていく予定。
