---
layout: post
title: "ranger-explorer.vimをアップデートした"
published: false
date: "2018-09-02"
comments: true
tags: 
   - "tig"
categories: "vim"
image: "https://i.gyazo.com/c4ce832cea5e7fcad3451fdfb21d03fd.gif"
description: "ranger-explorer.vimをアップデートしてranger上からvimのタブや画面分割で開けるようした"
---

ranger-explorer.vimをアップデートした。  
このアップデートでranger上の操作でvimのタブで開くか画面分割して開くかを選択できるようにした。  
(あとNeovimもサポートした)


# ranger-explorer.vimとは

https://github.com/iberianpig/ranger-explorer.vim

vimのファイラのrangerに置き換えるプラグイン。
vimからrangerでカレントディレクトリを開いたり、プロジェクトルートのディレクトリを開いたりできる。
また、vimの子プロセスのranger経由でファイルを選択するが、親プロセスのvimで開くようにしているのでbufferを共有することが出来る。(これが`!ranger`で開いた時との違い)


今回のアップデートでは __rangerから__ vimのタブや画面分割で開いたり出来るようにしている。


## ranger
ranger(https://ranger.github.io/)はCLIベースの高機能ファイラで、コマンドラインから操作できる。
hjklの移動、yyのヤンク、ddのカット、pのペーストなどVimライクな操作や、コマンドラインでの:rename、:touchなどの操作がサポートされている。

![ranger](https://ranger.github.io/screenshots/screenshot0.png)

特に高速なライブプレビューがが気に入っており、これだけでrangerを選択するモチベーションになっている。

# rangerからタブ/画面分割で開く

ranger-explorerからrangerを開いた時、下記キーバインドがrangerに自動的に定義される

```
<Ctrl-o>: 現在のタブ上で開く
<Ctrl-t>: 新しいタブで開く
<Ctrl-v>: 画面を垂直に分割して開く
<Ctrl-s>: 画面を水平に分割して開く
```

下のようにrangerから分割して開くことが出来る。
[![edit with vsplit from ranger](https://i.gyazo.com/c4ce832cea5e7fcad3451fdfb21d03fd.gif)](https://gyazo.com/c4ce832cea5e7fcad3451fdfb21d03fd)

動的にrangerへキーバインドを注入しているので、CLIからrangerを開いた時はこれらのキーバインドは使えず、tig-explorerから開いた時のみタブや画面分割が出来るようになる。

また、動的にアサインするキーバインドは `~/.vimrc` で下記のように上書きできる。

```vim
let g:ranger_explorer_keymap_edit    = '<C-o>'
let g:ranger_explorer_keymap_tabedit = '<C-t>'
let g:ranger_explorer_keymap_split   = '<C-s>'
let g:ranger_explorer_keymap_vsplit  = '<C-v>'
```

# ワークフローの一部として
ranger.vimを利用していたが、vim-filerと同等の使い勝手が欲しくてタブや画面分割する機能を実装した。
同じアイデアはGitクライアントtigを扱うプラグインのtig-explorer(https://github.com/iberianpig/tig-explorer.vim)にも取り込んでいる。


無理に全てvimプラグインで頑張るよりも得意なツールにまかせてしまえば良いと考えていて、
ファイルを開くツールは得意分野別にCLIツールに依存させている。

* 雑なファイル検索は[fzf.vim](https://github.com/junegunn/fzf.vim/)
* ディレクトリ階層からファイルを開くのには[ranger-explorer.vim](https://github.com/iberianpig/ranger-explorer.vim)
* コミット履歴や`git grep`からファイルを開くのには[tig-explorer.vim](https://github.com/iberianpig/tig-explorer.vim)

どれもプレビューが高速なツールを使えるようになったのでvim上ワークフローが快適になった。
