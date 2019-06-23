---
layout: post
title: "Elementary OS freyaでハイバネートオプションを追加する"
published: true
date: 2015-05-04
comments: true
tags: 
  - Linux
  - elementaryOS
image: https://i.ytimg.com/vi/PrFNYW99vSM/hqdefault.jpg
---

少し前からElementaryOSの最新版Freyaを使っている。  
電源周りで少し手こずったので、備忘録として残しておく。  
インストール後にやったことはまた今度まとめる。  

# ハイバネートオプションを追加する

Elementary OS Freyaでハイバネートが利用できなかったので、利用できるようにする。  
※ メモリ領域のデータをディスクに退避することで、作業状態を保存した状態で電源オフにし、電源オンでそこから復帰できる。
サスペンドはメモリに電源供給しながらデータを保持。メモリは揮発性で、電源供給がないとデータが消えてしまうため。

pm-utilsを導入してpm-hibernateコマンドを実行する手もあるが、今回は別の方法で。

## 電源オプションの中にハイバネートを追加する

`sudo vi /etc/polkit-1/localauthority/50-local.d/com.ubuntu.enable-hibernate.pkla`

<!-- more -->

下記をコピー&ペースト

```
[Re-enable hibernate by default in upower]
Identity=unix-user:*
Action=org.freedesktop.upower.hibernate
ResultActive=yes

[Re-enable hibernate by default in logind]
Identity=unix-user:*
Action=org.freedesktop.login1.hibernate
ResultActive=yes
```

## Grubの設定
`sudo vi /etc/default/grub`

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash resume=/dev/sda3"
```
resume='スワップ用パーティション'とすること！

### Grubの更新

`sudo update-grub`

これでシャットダウンのオプションなどで、`休止状態`(もしくは`ハイバネート`)が増えているはず。


# ノートPCを閉じた時にハイバネーションを有効にしたい && ロック画面でのPowerボタンの挙動を変える

自分の場合はロック画面の状態（だがディスプレイオフ）で電源を押して復帰しようとして、シャットダウンしてしまう現象に悩まされていた
デフォでこの動作はバグと言っていい気がする。あとノートPCなので、急なとき閉じて移動、などあるのでその際はハイバネートできたほうが良い。

## /etc/systemd/logind.confの編集
`man logind.conf` で確認したところ、HandlerPowerKeyやHandleLidSwitchなど、電源周りの挙動を変えられるようだった。

`sudo vi /etc/systemd/logind.conf`にて該当箇所のコメントアウトを外し、 下記に変更する

```
HandlePowerKey=hibernate
HandleLidSwitch=hibernate
```

再起動後、ロック画面での電源ボタン、 PCの閉じる動作によるハイバネートが有効になっているはず。
