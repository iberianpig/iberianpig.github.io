---
layout: post
title: "GenyMotionのelementaryOS12.04へのInstall"
published: false
date: 2014-07-09
comments: true
tags: 
  - elementaryOS
categories: android
---

# 爆速Android用のエミュレータGenyMotion導入

最近巷で爆速と噂のGenyMotion入れてみます。   
※ Ubuntuでも同じ導入手順です。  
![alt](/images/genymotion.png "謎のおっさん")  



## VirtualBoxのInstall

UbuntuソフトウェアセンターでVirtualboxをインストールします。  
![alt](/images/software_center_virtualbox.png  "VirtualBoxのInstall")

<!-- more -->
## GenyMotionのDownload  

![alt](/images/androVM_download.png "AndroVMのダウンロードサイト")  
[AndroVMのダウンロードサイト](http://androvm.org/blog/download/)にてダウンロード。  
ダウンロード前に[ここ](https://cloud.genymotion.com/)でユーザ登録を行う必要があります。  

## GenyMotionのInstall

### ダウンロード後のファイルの配置

お好きな場所に配置します。私は/opt/に配置しました。

    cd ~/Downloads/
    sudo mv genymotion{*version番号*}.bin /opt/

### 実行権限の変更

    cd /opt/
    sudo chmod 755 genymotion{*version番号*}.bin

### installerの実行

    sudo ./genymotion{*version番号*}.bin

この例では `/opt/genymotion/` にインストールされます。

### installerの削除

インストーラーは不要なので削除します

    sudo rm genymotion{*version番号}.bin

### pathを通す

このままでは`/opt/genymotion`以下からしか呼び出せません。  
pathを通します。

    echo 'export PATH=$PATH:/opt/genymotion' >> ~/.bashrc
    source ~/.bashrc 

## GenyMotion実行

terminalで`genymotion`で実行  
![alt](/images/terminal_genymotion_launch.png "ターミナルから実行。おっさんのメガネ？")  

### User情報の追加

登録したユーザ情報を入力する必要があります。

![alt](/images/genymotion_set_password.png "ユーザ情報の追加")  


### デバイスの追加

Addボタンからデバイスを追加します。  
![alt](/images/genymotion_window.png "デバイスの追加")  

一覧からデバイスイメージを選択します。  
![alt](/images/genymotion_select_image.png "デバイスの選択")  

デバイス名を登録します。  
![alt](/images/genymotion_create_device.png "デバイス名の登録")  


### デバイスの起動  

Playボタンからデバイスを起動します。  
![alt](/images/genymotion_launch.png "デバイスの起動")  


これで起動完了です。  
![alt](/images/genymotion_launched_image.png "サクサク動くデバイスイメージが起動しました")  
快速快適GenyMotion!めっちゃサクサクです！  
また、Terminalからではなく、Eclipse or AndroidStudioプラグインをインストールして
そこから立ち上げることも可能です。  (むしろソッチのほうがおおいかな)

