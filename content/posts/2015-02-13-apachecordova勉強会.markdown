---
layout: post
title: "ApacheCordova勉強会第4回"
published: true
date: 2015-02-13
comments: true
tags: 
  - Cordova
  - PhoneGap
categories: HTML5
---

# ApacheCordova勉強会第4回

AdobeからPhonegap開発チームの方々が来られていた。  

以下雑なメモ。  
<!-- more -->

## セッション1：米Adobe PhoneGapチーム【逐次通訳】
Adobeの人(Adobeに買収された開発チームの方)のセッション。英語同時翻訳。(ありがとうございました)  

* パフォーマンス問題としていいニュース
  - Apple、GoogleともにWebViewの高速化が進む
    * Appleもなんか出したらしい
    * AndroidのはおなじみCrossWalk projectの事

* Why Phonegap?
  - CrossPlatforms
  - ProjectSpeed
  - UI
  - Native functions
  - Update from Web
    * Appstoreを通さないアップデートができるとのこと ( てか、それいいの？ )
  - Plugin support

* ShowCase ( PhonegapAppStoreで見れるよ )
 - BankOfAmerica
 - Sabre - TripCase(HTML5/JSでゴリゴリ書いてるらしい)
 - Untappd
 - Sworkit
 - Large Home Store

* Instagram・Evernoteなどはハイブリッドアプリ(割合とかは言ってなかった)
* BaseCampもHybrid
 - ほとんどがHTML5ベース
 - Rails作者, DHHも情報が多いアプリだとHybridは向いているとのコメントを寄せていた

* PhoneGap Enterpriseについて
  * Adobeのマネタイズのはなし
  * ダッシュボードでメタデータ統計など利用可能
  * マーケの人が(コンテンツなどを)管理画面から簡単に更新可能

## セッション２： Visual Studio を使用した Cordova 開発

MSの方の話。主にVisualStudioの話でしたので話半分にしか聞けていません。。。

* VisualStudio
  - ユニバーサルアプリ(Windows系アプリケーション)はネイティブコンパイルで４倍速。
  - 補完の話とか便利機能の話
  - ...

## セッション３： Windows開発者が知っておきたいCordova開発の話
Monaca作ってるアシアルの方の話。
Win上でのCorova開発iOS開発の壁を超える

* chromeとUSBMAXD proxy つなげばiOSデバッグできるよ
* GapDebugを使えばUSBMAXD互換なのでiOS/Android開発できるよ
* BuildはBuildサーバとしてクラウドやMacを使う
* リリースはどうしようもない、ApplicationLoaderがないとアップロードすることができない。
  - 代行サービスがあるよでもID/パスワード必要だよ(笑)
* Android -> iOSの開発順序の方がハマることは少ないらしい

## その他

* 飲み会でAdobeの方々， SmartFxの中の人とか居て色々話し聞けた。
* React Nativeが気になってる人がやはり少なからず居たようだ。
  - パフォーマンスの観点がモバイルだと重要なのでそこら辺がどうなるのか気になる。

