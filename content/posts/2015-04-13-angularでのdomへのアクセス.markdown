---
layout: post
title: "AngularでのDOMへのアクセス"
published: true
date: 2015-04-13
comments: true
tags: 
  - javascript
  - angularJS
---

AngularがDOMのdata-x属性の値を取得する必要があったのでメモ。  
  
今回はdata-x属性内のハッシュ構造のデータを取り出す必要があった。  
  
`<SELECTOR data-x = '{"id":"123", "name":"hoge"}'...>`というDOM要素が存在した時  
  
`str = angular.element('SELECTOR').attr('data-x')`のような形式でデータを取得することができる。  
  
しかしこの状態ではstrはただの文字列として取得した状態なので、ハッシュを取り出すにはパースしてあげる必要がある。  
  
`hashed_data = angular.fomJson(str)`  
  
これで`hashed_data = {"id":"123", "name":"hoge"}`が取得できる。

