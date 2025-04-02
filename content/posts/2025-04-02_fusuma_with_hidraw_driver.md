---
layout: post
title: "HHKB StudioのポインティングスティックでThumbsenseを利用するFusumaプラグインを書いた"
draft: false
date: 2025-04-02T01:46:38+09:00
comments: true
tags: 
   - "linux"
   - "ruby"
image: "https://i.gyazo.com/d5a87784aad5ed3769d4ad5efe8723bc.png"
description: "HHKB StudioのポインティングスティックでThumbsenseを利用するため、HIDRawドライバを用いたFusumaプラグインを書きました"
---

Fusumaプラグインの一つであるfusuma-plugin-thumbsenseを機能拡張して、HHKB Studioのポインティングスティック(トラックポイント)に触っているときのみFキーやDキーをマウスボタンにリマップできるようになった。


# 登壇資料

[Fukuoka.rb #397 〜RubyKaigi 2025の機運〜](https://fukuokarb.connpass.com/event/345164/)でLTしてきました。
<iframe class="speakerdeck-iframe" frameborder="0" src="https://speakerdeck.com/player/52e19275d015488a838d43452dd8c730" title="RubyKaigiで手に入れた HHKB Studioのための HIDRawドライバ" allowfullscreen="true" style="border: 0px; background: padding-box padding-box rgba(0, 0, 0, 0.1); margin: 0px; padding: 0px; border-radius: 6px; box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 40px; width: 100%; height: auto; aspect-ratio: 560 / 315;" data-ratio="1.7777777777777777"></iframe>

HIDRawドライバを利用することで汎用カーネルドライバではフィルタリングされてしまっていたイベントが取得できるようになり、指を軽く置くだけでタッチを検出できるようにした。

取得した生のHIDイベントは、通常のevdev相当の構造体に変換する必要がある。イベントストリームのバイト列の区切りを見つけるために、事前にHID Report Descriptorを解析しておき、デバイス別にキーやポインティングデバイスの操作イベントにデコードする。

HidAPIのバインディングライブラリをいくつか試したが期待通りに動作しなかった。マウスのイベントが飛んできているときだけは雑にタッチ判定しておけばとりあえず動くものは作れそうだったのでffiやC拡張に頼らずRubyで実装した。

# 実装内容

[![https://github.com/iberianpig/fusuma-plugin-thumbsense/pull/4](https://i.gyazo.com/de822307748283960c2ea576655338c3.png)](https://github.com/iberianpig/fusuma-plugin-thumbsense/pull/4)
↑はポインティングスティックからタッチイベントを取得するPR(https://github.com/iberianpig/fusuma-plugin-thumbsense/pull/4)


USB接続時とは異なり、Bluetooth接続時は同一デバイス上でキーボードとポインティングデバイスの両方が通信に乗ってくるため、report_id分のバイト列の有無や不要なバイト列を読み飛ばす処理が必要となり、その結果パーサーを2種類に分割する実装となっている。

# 課題など

ちゃんと汎用ドライバのようにやるにはHID Report Descriptorから動的に構造体を作ってHIDレポートをデコードする必要がある。すると色々なデバイスで同じようにイベントがパースできるようになり、ThinkPadのトラックポイントやトラックボールなども対応が簡単になる。

Fusuma側のリマップ処理については、fusuma-plugin-remapにおいて、evdevで物理デバイスからイベントをgrabし排他制御を行った上で、uinputにより作成された仮想デバイスへイベントを書き換えるプロキシが実装されている。

fusuma-plugin-remap自体にC拡張を使っているのでRubyを普段使わないユーザはOSのruby-devのパッケージとインストール時のビルドが必要になってしまったり、
ユーザ側でデバイスファイルのパーミッション用のudevルールを作成する必要があったりする。

このあたりの面倒事を軽減するにはX11やWayland(libinput + libei)上でリマップしてしまうか、 リマップ周りをeBPFを使ってカーネル空間に処理を移譲してしまって、フィルタリングやリマップをセキュアに処理を移譲する手法もあったりしてどの辺りに進むかは検討中。

またC拡張を使わずにPure Rubyでlibevdev/libinputなど自分が使う範囲だけ再実装しちゃうのも意外とできちゃうんじゃないかと思っていて、気分次第でどれかに進捗を出していきたい。

自分が遊べる余白を残しながら他の人にも安定して使ってもらえるのはプラグイン化のメリットの一つだなと思う。
