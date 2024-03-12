---
layout: post
title: "Authy Desktopが終了するので秘密鍵を抽出して他ツールへ移行する"
draft: false
date: 2024-03-10T17:04:08+09:00
comments: true
tags: 
   - "Linux"
image: "https://i.gyazo.com/2b59469c61ee89377043ba87e101bbcd.png"
description: "Authy Desktopが2024年3月にサービス終了するので、秘密鍵を抽出して他ツールへ移行することにした"
---

## Authy Desktopが2024年3月にサービス終了

- [公式](https://help.twilio.com/articles/19753631228315)
- [参考記事](https://iototsecnews.jp/2024/01/08/twilio-will-ditch-its-authy-desktop-2fa-app-in-august-goes-mobile-only/)

Authyは人気のある2FAアプリケーションの一つだったが、 2024年3月にデスクトップ用Authyが終了する発表されている。
元々は8月の予定だったが、3月に前倒しになった模様。

自分はAndroid, Linuxの環境下でAuthyを使っていたがデスクトップ版が終了するため、モバイル版はAegisとデスクトップ版はGnome Authenticatorに移行することにした。

## 移行先の選定

Authyの一つ大きなポイントはデスクトップ・モバイルデバイス間の各クライアントでの同期だが、これはAuthyのサーバ経由で秘密鍵を同期することで実現されている。 

AegisはOSSのTOTPクライアントだが、Android向けしかないため、デスクトップ向けにはGnome Authenticatorを使うことにした。

- Aegis
  - Google play https://play.google.com/store/apps/details?id=com.beemdevelopment.aegis
  - GitHub https://github.com/beemdevelopment/Aegis
  - Aegisの記事 https://gigazine.net/news/20230128-aegis-authenticator-review/
  - AegisのバックアップとしてGoogle Authenticator形式の複数の秘密鍵をまとめたQRコードが出力できる(他にも標準的な形式のインポート・エクスポート形式をサポートしている)

- Gnome Authenticator
  - Fluthub https://flathub.org/apps/com.belmoussaoui.Authenticator
  - GitLab https://gitlab.gnome.org/World/Authenticator
  - flatpakで導入するGnome AuthenticatorはGoogle Authenticator形式のQRコードをWebカメラから読み込むことができる
  - Aegisのバックアップ用QRをWebカメラにかざして読み込ませることでAuthyの秘密鍵の同期相当が行える

- ちなみに以下も選択肢としては良いと思う
  - Google Authenticater自体も最近 バックアップ/QRのエクスポート機能が追加されていて(Aegisで利用している一括のQRコード形式)が扱える
  - 2fas(https://2fas.com/) は iOS / Android / Chrome Extension クライアントがあり、こちらに寄せるのもアリかも

## AuthyからTOTPの秘密鍵のエクスポート

公式を漁ったがAuthyの秘密鍵をエクスポートする方法が見つからなかった。
どうやらAuthyの秘密鍵のエクスポートはサポートされていないため、各自で何らかのアプリやツールを用いた移行が必要となる。

rootが取れるAndroid端末があれば、Aegisや他のアプリからもエクスポートできるらしいが自分はroot取得していないので https://github.com/token2/authy-migration を使った。

- authy-migrationはクライアントのふりをしてバックアップから秘密鍵をダンプする
  - 廃止されたAuthy Chrome Appのapi_keyを内部で使っている模様
  - 2024年3月現在はまだ使えているが、APIキーがいつまで使えるかは不明なので早めに移行すべき

- Authy側の設定でバックアップを有効にしておく
  - Authyの秘密鍵のバックアップはクライアント側で暗号化してサーバにアップロードしている(https://authy.com/blog/how-the-authy-two-factor-backups-work)
  - 移行が終わったらバックアップを無効化にしておくと良さそう


- リポジトリをクローンし、コードを読んで問題なさそうだったのでターミナルで以下のコマンドを実行した

```sh
$ go run ./cmd/authy-export/authy-export.go
```

- 国番号, 電話番号を入力する
- モバイルのAuthyアプリから新規クライアント追加の通知が飛んでくるので許可
- バックアップ用のパスワードを入力し、暗号化されたデータを復号
- エクスポートする形式はファイル名で形式が変わるようで.htmlだと複数のQRが入ったHTMLが出力される


## Aegis / Gnome Authenticatorへのインポート

- Aegisのアプリからauthy-migrationで取り出したHTML上のQRコードをスキャンし、その後Gnome Authenticatorにまとめてインポートすることでデスクトップとモバイルの同期が行える。
- 今後はAegisに追加 → QRコードをGnome Authenticatorで読み込むという手順で同期する(追加頻度が高くなければ都度同期でも良い)
- AegisはAndroidのクラウドバックアップがサポートされているが、他のクラウドストレージに同期しつつ、デスクトップと共有するのも良いかもしれない

## まとめ

- 秘密鍵のエクスポートをサポートしないAuthyから柔軟な2FA管理に移行した
- 依存するツールはエクスポート/インポート機能と標準形式を含む複数の形式をサポートしていることが重要(自戒)
