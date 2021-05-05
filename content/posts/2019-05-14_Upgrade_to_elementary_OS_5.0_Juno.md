---
layout: post
title: "Upgrade to elementary OS 5.0 Juno"
draft: false
date: 2019-05-14T15:38:04+09:00
comments: true
tags: 
   - "elementaryOS"
image: "https://i.gyazo.com/b91034c425a91a6bda3ad6af608a61ac.png"
description: "elementary OS 5.0 Junoにアップグレードした"
---

下書きが2019-05-14T15:38:04+09:00 となっているので1年以上塩漬けされた記事である😨 (2020/06/05)

elementary OSはUIが綺麗でかつ動作も軽快なので、5年ほど愛用している。今回、新バージョンの5.0Junoが出てしばらく経っていたのでアップグレードすることにした。

<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://elementary.io/ja/" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Felementary.io%2Fja%2F&amp;key=f073c4f447189e73167146bd9d0f6195&amp;iframe=card-small"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

`Unetbootin`を利用してelementary OS Junoにアップグレードする。

実際はクリーンインストールなのだが、elementary OS自体は公式でアップグレードパスを用意していない。
`/home`と`/`を別パーティションに分けていたので、データ領域である`/home`を残してそれ以外を新しい環境に移行する。


# 環境
- Dell XPS 13 9360
- OS: elementary OS 0.4 Loki → elementary OS 5.0 Juno

パーティション
```
Filesystem      Size  Used Avail Use% Mounted on
/dev/nvme0n1p1   42G   17G   23G  42% /
/dev/nvme0n1p2  177G  151G   17G  90% /home
```

今回 `/` の領域をフォーマットして5.0 Junoをクリーンインストールし、
`/home`には個人の設定(`XDG_CONFIG`や`dotfiles`)やドキュメント類などが置いてあり、ここは引き続き利用する。

インストールには`Unetbootin`を利用した。

Unetbootinについてはこちらをご参考に↓
<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://kledgeb.blogspot.com/2016/04/unetbootin-3-unetbootinubuntuusb.html" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fkledgeb.blogspot.com%2F2016%2F04%2Funetbootin-3-unetbootinubuntuusb.html&amp;key=f073c4f447189e73167146bd9d0f6195&amp;iframe=card-small"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>


# アプリケーションのインストール

`/home`以外はクリーンインストールなので、`apt`や`/usr/local/bin`でインストールしていたものは再インストールする必要がある。

## Ansibleでローカル環境の再構築

`Ansible`でローカル環境の再構築を楽に行えるようにしたかったので、アプリケーションのリスト程度だが`dotfiles/.config/ansible/playbook.yml`に残している。

<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://github.com/iberianpig/dotfiles/blob/master/.config/ansible/playbook.yml" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fgithub.com%2Fiberianpig%2Fdotfiles%2Fblob%2Fmaster%2F.config%2Fansible%2Fplaybook.yml&amp;key=f073c4f447189e73167146bd9d0f6195"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

`ansible-playbook`コマンドでリポジトリの追加、パッケージインストールを下記のコマンドで行う。

```
ansible-playbook ~/.config/ansible/playbook.yml -K
```

# インストールしたアプリケーション一覧

## ブラウザ

 - [Google Chrome](https://www.google.com/chrome/)
   - メインブラウザ
   - 手動でインストール
 - Chromium
 - Firefox

## パスワードマネージャ

 - bitwarden
   - snapでインストール可
   - Chrome拡張もある


## 画像編集系

 - Gimp
   - 画像編集
 - Inkscape
   - ベクタ系の画像編集

## ターミナル/CLI環境

 - byobu
   - tmuxのラッパー
 - guake
   - ドロップダウンタイプのターミナル
 - git
   - バージョン管理
 - tig
   - gitのCUIクライアント
 - ranger
   - VimライクなCUIファイラ
 - vim-gnome
   - GVim。クリップボード拡張入りのVimも入る。
 - xclip
   - CLIクリップボードマネージャ

 
## チャット 

   - [Slack](https://slack.com/intl/ja-jp/downloads/linux)
     - 仕事で使うチャットアプリ
   - [Line](https://chrome.google.com/webstore/detail/line/ophjlpahpchlmihnnnihgmmeilfjmjjc?hl=ja)
     - chrome拡張

## デスクトップ拡張/GUI

 - numix-icon-theme
   - お洒落なデスクトップアイコンセット
 - elementary-tweaks
   - elementaryOSのデスクトップの詳細設定
 - fcitx-mozc
   - 日本語入力
 - xbindkeys
   - 任意のコマンドにショートカットを割り当てる
 - [Fusuma](https://github.com/iberianpig/fusuma)
   - マルチタッチジェスチャ
   - gemコマンドでインストール。Rubyが必要。
   - インストールとカスタマイズ方法(https://iberianpig.github.io/posts/2019-02-22_cusomize_fusuma/)

 - [Dropbox](https://www.dropbox.com/ja/install-linux)
   - デバイス間のファイル共有


## 設定編集


## システム設定

 - synaptic
   - aptのGUIフロントエンド
 - gdebi
   - debファイルの依存関係解決
 - fwupd
   - BIOSやデバイスのファームウェアのアップデート。uefiのみで利用可
 - snapd
   - Snapを使えるようにする
 - powertop
   - 消費バッテリーのモニタリング
 - tlp
   - 節電用ユーティリティ
 - baobab
   - ディスク管理
 - gparted
   - パーティション管理
 - etckeeper
   - `/etc`のバックアップ

 - dconf-editor
   - dconf利用アプリケーションの設定値変更
 - gconf-editor
   - gconf利用アプリケーションの設定値変更

## その他

 - playonlinux
 - calibre

## オフィス

 - libreoffice

## 動画・音楽

 - Spotify
   - 音楽プレイヤー
 - VLC
   - 動画プレイヤー

## デスクトップキャプチャ

 - gyazo
   - キャプチャした動画や画像をホスティング
 - scrot
   - スクリーンショット
 - byzanz
   - Gifアニメーションでキャプチャ
 - obs-studio
   - デスクトップ配信

### リモートデスクトップ
 - remmina

### 開発用
 - docker-ce
 - jq
 - direnv
 - make
 - automake
 - autoconf
 - pkg-config
 - tree
 - sassc
 - gcc
 - python-pip
 - libreadline-dev
 - shellcheck
 - global
 - awscli
 - libmysqlclient-dev
 - mysql-server
 - virtualbox
 - virtualbox-ext-pack
 - ngrok


# grubの設定

```
GRUB_DEFAULT=0
GRUB_TIMEOUT_STYLE=hidden
GRUB_TIMEOUT=5
GRUB_RECORDFAIL_TIMEOUT=5
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer resume=UUID=9844e045-cffd-4fac-806d-9b1f3f430edf zswap.enabled=1 zswap.compressor=lz4 zswap.max_pool_percent=25 i915.enable_fbc=1 i915.enable_psr=1 i915.disable_power_well=0"
GRUB_CMDLINE_LINUX=""
```

## hibernateオプションの設定

<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://iberianpig.github.io/posts/2015-05-04-elementary-os-freya%25E3%2581%25A7%25E3%2583%258F%25E3%2582%25A4%25E3%2583%2590%25E3%2583%258D%25E3%2583%25BC%25E3%2583%2588%25E3%2582%25AA%25E3%2583%2597%25E3%2582%25B7%25E3%2583%25A7%25E3%2583%25B3%25E3%2582%2592%25E8%25BF%25BD%25E5%258A%25A0%25E3%2581%2599%25E3%2582%258B/" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fiberianpig.github.io%2Fposts%2F2015-05-04-elementary-os-freya%E3%81%A7%E3%83%8F%E3%82%A4%E3%83%90%E3%83%8D%E3%83%BC%E3%83%88%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%92%E8%BF%BD%E5%8A%A0%E3%81%99%E3%82%8B%2F&amp;key=f073c4f447189e73167146bd9d0f6195&amp;iframe=card-small"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

以前の方法のとおりだと上手くいかずにハマった。  
`resume=UUID=9844e045-cffd-4fac-806d-9b1f3f430edf`のように必ず、**UUID**で指定をすること。


> ここで注意なのは、initramfs の resume ファイルに設定したものと同じ文字列を設定する必要があります。同じパーテーションだからといって、resume=/dev/sdaX のように違う指定の方法をすると動作しません。initramfs の方で UUID で指定したら、grub の設定も UUID で指定してください。
<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://petit-noise.net/blog/hibernation-on-ubuntu-18-04/" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fpetit-noise.net%2Fblog%2Fhibernation-on-ubuntu-18-04%2F&amp;key=f073c4f447189e73167146bd9d0f6195"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>


## zswapの設定

メモリが8GBと開発機としては少し物足りないのでzswapを設定しておく。

`/etc/default/grub`と`/etc/initramfs-tools/modules`を修正する。

こちらのリンクを参考に設定した

[Zswapを有効にして少ないメモリを乗り切ろう - Days of Speed(2018-02-06)](http://www.nofuture.tv/diary/20180206.html)

# UEFIの設定
最初、BIOSブートでインストールしてしまったため、あとからUEFIブート出来るように`/boot/efi`にgrubをインストールした。

1. Ubuntuの入ったLiveUSBを作り、BIOSの設定を弄ってUEFIモードでLiveUSBのUbuntu起動
2. gpartでパーティションをfat32で切る
3. elementaryOS側(PC側)の各デバイスをLiveUSB側からmountし、grubインストール
4. `/boot/efi`のマウント指定を`/etc/fstab`に記述して保存
5. 再起動するとUEFIモードでelementary OSが起動する

このやり方覚えておくと、間違って`/boot`削除したとしても大丈夫。

詳しくはこちらの記事参照。

<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="http://nodemand.hatenablog.com/entry/2016/11/11/175929" data-iframely-url="//cdn.iframe.ly/api/iframe?url=http%3A%2F%2Fnodemand.hatenablog.com%2Fentry%2F2016%2F11%2F11%2F175929&amp;key=f073c4f447189e73167146bd9d0f6195&amp;iframe=card-small&amp;media=0"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

# fwupdでファームウェアの最新化

fwupdでデバイスの更新、取得を行う

<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://github.com/fwupd/fwupd" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fgithub.com%2Ffwupd%2Ffwupd&amp;key=f073c4f447189e73167146bd9d0f6195"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

最近はSnapでインストールできるのようになっている模様


# ネットワーク周りの対応 

ネットワークがブツブツ切れるような問題になった際に行った対応

## ath10k-firmwareの更新

XPS 13シリーズで不評なKiller 1535 Wirless Adapterのファームウェア(ath10k/QCA6174)をGitHubから取得して更新する

<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://github.com/kvalo/ath10k-firmware" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fgithub.com%2Fkvalo%2Fath10k-firmware&amp;key=f073c4f447189e73167146bd9d0f6195"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

```shell
$ git clone https://github.com/kvalo/ath10k-firmware
```

リポジトリにあるファイルを/lib/firmware配下のものと置き換える。 
参考: [Dell XPS 13 9360 : Ubuntu Wifi disconnection](https://gist.github.com/Samffy/97cb1dd9cb89f5ac29ac4af2affd43f2)

よくやってる処理なのでMakefileにしてリポジトリのルートに配置して更新している。

<script src="https://gist.github.com/iberianpig/5b7c275bed9ec69562b7bc728c84b8d1.js"></script>

```shell
$ make backup_QCA6174 # /lib/firmware/ath10k/QCA6174をバックアップ
$ make update # リポジトリから取得したものと差し替え
```

## カーネルパラメータの見直し
GRUB_CMDLINE_LINUX_DEFAULTカーネルパラメータに省電力設定が入っている場合`pcie_aspm=off`にしておくとネットワーク周りが安定することある。
