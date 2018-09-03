---
layout: post
title: "会社のPCのWindowsマシンにLubuntuを入れてきた"
published: true
date: 2015-09-17
comments: true
tags: 
  - lubuntu
categories: Linux
image: https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Lubuntu_15.10_English.png/800px-Lubuntu_15.10_English.png
description: "lubuntu(軽量版GUIを備えたUbuntuベースのLinuxディストリビューション)を3時間くらいかけてセットアップした時の備忘録。"
---

Webライターさん向けにChromeとOfficeツールが使える格安環境が欲しいとのことで、同僚が買ってきた1万5000円のWindowsPC。
デフォルトで入っている(おそらくkitting時に自動で入る)セキュリティツールが悪さをしてまともにブラウジングができなかった。  
その要件であれば、lubuntu(軽量版GUIを備えたUbuntuベースのLinuxディストリビューション)を使えばよいだろうということで、
3時間くらいかけてセットアップした時の備忘録。

<!-- more -->

# WinowsPCにlubuntuを入れる
  1. Windowsのコンピュータを起動し、コントロールパネルから"ディスクの管理"を表示する
  * "ディスクの管理"の画面の写真を取る（スクショはだめ。インストール中に見れない）
    * 今回はDドライブの内容が空だったので、Lubuntu側でDドライブをフォーマットすることにする。
    * Dドライブのディスク空き容量68.43GB。Dドライブの容量の数値を確認しておく。
  * UnetBootInDiskでLinuxをブート可能なUSBメモリを作る
  * メーカーロゴでF12連打でブートメニューに入って、USBメニューを選択（なければBIOS設定画面に入ってから設定を変更する)。
  * Try Installを選択。
  * 言語で日本語を選択。
  * ネットワーク（Wifi）に接続できるので、接続（あとでもできるがこのタイミングのほうが失敗が少ない）
  * インストール中にアップデートをダウンロードする、サードパーティ製のソフトウェアをインストールの両方にチェック
  * インストールの種類で”それ以外”を選択
  * ブートローダをインストールするデバイスに/dev/sda(ディスクの大元)を選択。
  * Dドライブの存在していた`/dev/sda4/`(ディスクの管理でとった写真を参照）を選択し、`-`をクリック。
  * 空き領域を選択、 + をクリック。論理パーティションを選択。ext4ジャーナリングシステムを選択。マウントポイントに"/"を選択。
    * これで論理パーティション内部に複数のパーティションが作成可能になる。
    * スワップ領域を作らなくてよいかとの画面が出るが、無視してよい。あとで追加する。
  * マシン名とユーザ名とパスワードを設定する。Windows側と同じユーザ名、パスワードを利用。
  * タイムゾーンはTokyoに。キーボードは日本語に設定する。

# Lubuntuをセットアップする
  * スワップを有効化
    * USBからtry without installを選択
    * gpartedを利用して論理パーティション内1GBのスワップを作る。swap領域の`/dev/sdxx`
    * fstabを`sudo vi /etc/fstab`にて編集。 ( http://linuxsalad.blogspot.jp/2009/05/swap.html )
    * 再起動して`gparted`上でスワップオンになっていることを確認
    * swapがないとたまにフリーズしたりするので早めに設定しておくこと
  * 日本語を入力できるようにする
    * Ctrl-Spaceで日本語入力可能。ibus-anthyが使える。
    * 変換精度のより良いibus-mozc(Google日本語入力)を入れる。コマンドは`sudo-apt-get install ibus-mozc`。
    * キーボードインプットメソッドでibus-mozcを追加。
    * インプットメソッドの切替キーを半角に設定する（hankakuを追加割り当てする)。
  * GoogleChromeを入れる(firefox起動してそこから検索してインストールする)
  * LibreOffice(OpenOfficeのすごいやつ)を入れる
  * よく使いそうなソフトはデスクトップにショートカットを置く
      * Chrome
      * ファイルマネージャ
      * LibreOffice Writer(Word)
      * LibreOffice Calc(Excel)
  * 見た目整える
    * 綺麗な日本語フォントをAdobeが出してる(源ノ角フォント)のでそれを入れる。`mkdir ~/.font/`してそこに展開。
    * ログアウトし、ログインするとルックアンドフィールなどからフォント設定。
    * FaenzaIconsをダウンロードして設定。

# やってみての感想

やはり時間かかった(3h)。ほとんどはパーティションとスワップ周りの調査。

以下が得られた知見達。

* 論理パーティションを作るには基本パーティションをフォーマットしなければならない。
* swapとか使うなら論理パーティション必須。
* Installより先にUSBブートしてGpartedで基本パーテイションの1つを論理パーティションにフォーマットする。
* その論理パーティションの中でメモリ容量x2程度の小さなパーティションを作成する。
* Lubuntuのインストーラ内で上記のパーティションをSwapに割り当てる。
* Install時に割り当てられなかったらfstabで設定。再起動後Gpartedで割り当て確認。
* Swap割り当てないとマウスポインタだけ動いてキーボードが操作不能になる。
* LubuntuでCtrl+Del+BackSpaceでKill Xserverが簡単に設定できる箇所が見つからなかった。
