---
layout: post
title: "Head-First-Rails_5"
published: true
date: 2014-03-17
comments: true
tags: 
categories: rails
---

# Head First Rails 第5章のメモ
※ rails3の書籍をrails4で読み替えてチュートリアルを進めています。  

scaffold で生成したアプリケーションのフォームに
バリデーションを設定していく。

##バリデーションの設定。

バリデーションの設定はモデル名．rbの中に設定する
`validates_xxxxxx_of` と記述する。

## エラー処理を自分で書く場合

scaffoldを利用していない場合にエラー処理を自分で記述する必要がある。  
画面に処理内容を表示するためにはSaveメソッドでの失敗をコントローラに伝える必要がある。  
そのため、 if文で@model.saveを実行した結果 true or false に応じて、リダイレクトを
行うか否かを決定する。  

form内で、f.error_messagesメソッドを利用する。

updateも同様。if文で@model.update_attributes(:params[:model])の実行し、結果に応じて
リダイレクトを行うか否かを決める。


## 不明点

### バリデーターのメッセージを変更方法
書籍内の`validates_presence_of :trainer, "What's your name?"`がうまく動かない

