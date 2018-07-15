---
categories: "Life"
comments: true
date: 2017-01-30T02:52:18+09:00
description: "長期記憶に持っていくための工夫。複数のWEBサービスを組み合わせて記憶に残す仕組みを作る"
image: "https://i.gyazo.com/e2361e2976238ea1b8fbc2401a1dd460.png"
layout: post
published: true
tags:
  - "Kindle"
  - "Pocket"
  - "Twitter"
  - "Buffer"
title: "記憶の定着率を上げるPocket+Kindle連携"
---

日々の情報収集のフロー内で記憶定着のために自分がやっていることを書いてみた。  

# エビングハウスの忘却曲線

エビングハウスの忘却曲線と復習の関係に注目すると、復習は少し時間を空けておいたほうが効率が良いと言われている。  

![エビングハウスの忘却曲線と復習の関係](http://free-academy.jp/junior/swfu/d/auto_zkqgEf.png)

1〜2日以内にチェックして短期記憶に、1週間後に再度見直して長期記憶に持っていく作戦。  
時間を空けて読むという行為をWebサービスを組み合わせてやってみる。  

なお、1日以内、1週間以内、2週間以内で3度復習したほうが良いらしいが、運用効率が悪いので期間はあまり厳密にしない。  

# 気になったらとりあえずPocketに入れる

[Pocket](https://getpocket.com)はWebページを"後で読むリスト"に追加してくれるサービス。
後で見返そう、今時間ないから後で見たい、難しいから復習しよう、と思った時にここに放り投げる。
スマホアプリや[Chrome拡張](https://chrome.google.com/webstore/detail/save-to-pocket/niloccemoadcdkdjlinkgdfekeahmflj?hl=ja)があって、ブラウジングしながら後で読むリストに追加できる。

# Pocketで見る(短期記憶)

Pocketのアプリをスマホに入れる。タブレットでも良いが、いつでも持っているものがいい。  
[![https://gyazo.com/d7f413be550f15e1be49049796fada73](https://i.gyazo.com/d7f413be550f15e1be49049796fada73.png)](https://play.google.com/store/apps/details?id=com.ideashower.readitlater.pro&hl=ja)

毎日の通勤時に記事をチェックする。  

# Kindleで記事を読む(長期記憶)
[P2K - Pocket to Kindle](https://p2k.co/)というサービスを使ってPocketの記事をKindleで読む。
[![P2K - Pocket to Kindle](https://i.gyazo.com/e2361e2976238ea1b8fbc2401a1dd460.png)](https://p2k.co/)


配信オプションが色々ある(daily/weekly, 記事の長さ、 取得順序、 etc)が、自分は30分程度で読める分を週1回Kindleに配信している。  

Kindleで読むのは週に1回（しかも長めの記事）になるので必然的にPocketに入れた時から期間が空くことになる。

週末に30分-1時間程度かけて読む。

# その他
Twitterを連携させて時間差付けてフィード流したり、後で読むリストに追加したりしている

* IFTTTでTwitter-> Pocketの連携
  - Twitterでいいねした記事を後で読むリストに追加する。
* IFTTTでPocket -> Buffer連携
  - Pocketでスターをつけた記事をBuffer経由で`#見てる`タグを付けてTwitterにポストする
  - Buffer経由することで時間を空けてツイートするので自分自身が記事を再チェック出来る

上記を取り入れた場合、3回以上同じ記事を目にすることになる。

## Special Thanks
* [忘却曲線 - Wikipedia] (https://ja.wikipedia.org/wiki/%E5%BF%98%E5%8D%B4%E6%9B%B2%E7%B7%9A)
* [エビングハウスの忘却曲線(ぼうきゃくきょくせん)](http://free-academy.jp/junior/index.php?%E3%82%A8%E3%83%93%E3%83%B3%E3%82%B0%E3%83%8F%E3%82%A6%E3%82%B9%E3%81%AE%E5%BF%98%E5%8D%B4%E6%9B%B2%E7%B7%9A)
* [「記憶」の仕組みを知って効率よく学習したい…その３、短期記憶の特徴と容量について - 烏は歌う](http://d.hatena.ne.jp/wander1985/20110501/1304258614)


