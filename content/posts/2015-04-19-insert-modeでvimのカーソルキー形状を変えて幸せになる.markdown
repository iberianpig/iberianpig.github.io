---
layout: post
title: "insert-modeでvimのカーソルキー形状を変えて幸せになる(gnome-terminalの場合)"
published: true
date: 2015-04-19
comments: true
tags: 
  - Vim
image: http://i.gyazo.com/523d7f4dc324943c6d55f00b69f4fa8b.png
description: Gnome-TerminalでVimのCommand/Normalモードの状態をよりわかりやすくするためのTips
---

# Command/Normalモードを間違う
  
問題はこれ。  
頻繁にどちらのモードかを勘違いしてしまってタイプミスをしてしまう。  
  
自分はgnome-terminal上でVimを使っている。tmuxなどターミナルマルチプレクサとの共存が必要だからだ。  
gVimではカーソル形状が矩形と'｜'が切り替わるのだが、ターミナル上では制限があって、調べたところ簡単ではなかった。  
  

<!-- more -->

# 暫定策
代替案として、 [lightline.vim]( https://github.com/itchyny/lightline.vim )を使ってInsert/Normalモードの状態を色付きで
画面下部に表示し、視覚的に理解しやすいように試みた。  
  
![lightline](http://i.gyazo.com/92223ba03c523c28e705980706a3a7e9.png)
確かにわかりやすいが、画面の端の色なので、気づかずにミスタイプになることも多い。  
  
また、横のラインを表示・非表示を( `autocmd InsertEnter,InsertLeave * set cursorline!` )で切り替える
アプローチも試みたが、モード間違いは大きく改善はしなかった。  
  
# 救世主
これまでかと思った矢先に、救世主が現れた(stackoverflowで記事を見つけた)

> To change the shape of the cursor in different modes, you can add the following into your vimrc.
> For the Gnome-Terminal (version 2.26)Edit

```vim
if has("autocmd")
au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
endif
```

  
![insert](http://i.gyazo.com/523d7f4dc324943c6d55f00b69f4fa8b.png)
![normal](http://i.gyazo.com/d8fb66d045fdc0b3ce9470d058bfe81e.png)  
すばらしい。  
グローバルな設定を書き換える力技だが、キニシナイ。  
  

# special thanks
* Lightline(https://github.com/itchyny/lightline.vim )
* Stackoverflow(http://stackoverflow.com/a/6488717/4040150)

