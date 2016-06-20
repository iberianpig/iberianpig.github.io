---
layout: post
title: "Head-First-Rails_4"
published: true
date: 2014-03-15
comments: true
tags: 
categories: rails
---

# Head First Rails 第４章のメモ
※ rails3の書籍をrails4で読み替えてチュートリアルを進めています。  


Scaffoldで作成したページを改造していく。

## 検索窓の導入

どのページにも検索窓を用意するので、layoutsを利用する
layoutfileは｛モデル名｝.html.erbとなる

form_forとform_tagの違い

## ハマったところ

書籍では<％ %>だったが、実際はform_tag は <%= %> で囲む必要があった  
(rails 3 と rails 4の違い？ )  

### routesの追記が必要。 formの追加に合わせて。
    post 'client_workouts/find' => 'client_workouts#find'


### rails4 だと Find で :conditionsが使えない

代わりにモデル名.whereを利用する  
* `モデル名.find(id)`
    - findはidの検索専用
* `モデル名.where(:カラム名 => 内容)`
    - なんか指定するときは大体where

### defaultで生成されるapplication.html.erbはいつ利用される？
いつも使われてて、マスタのテンプレートとして使われてる
どのViewもコントローラのメソッド（アクション）と紐づくViewが中にサンドイッチされて出力されてる。
