---
layout: post
title: "Head-First-Rails_4"
published: true
date: 2014-03-15
comments: true
tags: 
  - Rails
---

# Head First Rails第4章のメモ
※ rails3の書籍をrails4で読み替えてチュートリアルを進めています。  


Scaffoldで作成したページを改造していく。

## 検索窓の導入

どのページにも検索窓を用意するので、layoutsを利用する
layoutfileは｛モデル名｝.html.erbとなる

form_forとform_tagの違い

## ハマったところ

書籍では`<% %>`だったが、実際はform_tagは `<%= %>` で囲む必要があった  
(rails 3とrails 4の違い？　)  

### routesの追記が必要。 formの追加に合わせて
    post 'client_workouts/find' => 'client_workouts#find'


### rails4だとFindで :conditionsが使えない

代わりに`モデル名.where`を利用する  
* `モデル名.find(id)`
    - findはidの検索専用
* `モデル名.where(:カラム名 => 内容)`
    - なんか指定するときは大体where

### defaultで生成されるapplication.html.erbはいつ利用される？
いつも使われてて、マスタのテンプレートとして使われてる
どのViewもコントローラのメソッド（アクション）と紐づくViewが中にサンドイッチされて出力されてる。
