---
layout: post
title: "ranger-explorer.vimをアップデートした"
published: true
date: 2018-09-02T00:05:21+09:00
comments: true
tags: 
   - ranger
   - vim
   - git
image: "https://i.gyazo.com/c4ce832cea5e7fcad3451fdfb21d03fd.gif"
description: "ranger-explorer.vimをアップデートしてranger上からvimのタブや画面分割で開けるようした"
---

ranger-explorer.vimというVimプラグインをアップデートした。  
このアップデートでranger上の操作でVimのタブで開くか画面分割して開くかを選択できるようにした。  
(あとNeovimもサポートした)


# ranger-explorer.vim

https://github.com/iberianpig/ranger-explorer.vim

Vimのファイラのrangerに置き換えるVimプラグイン。
Vimからrangerでカレントディレクトリを開いたり、プロジェクトルートのディレクトリを開いたりできる。
また、Vimのプロセスがネストせず、rangerの親プロセスのVimで開くようにしているのでbufferを共有することが出来る。(これが`!ranger`で開いた時との違い)


今回のアップデートでは __rangerから__ Vimのタブや画面分割で開いたり出来るようにしている。


## ranger
[ranger](https://ranger.github.io/)はCLIベースの高機能ファイラで、コマンドラインから操作できる。
hjklの移動、yyのヤンク、ddのカット、pのペーストなどVimライクな操作や、コマンドラインでの:rename、:touchなどの操作がサポートされている。

![ranger](https://ranger.github.io/screenshots/screenshot0.png)

特に高速なライブプレビューが気に入っており、これだけでrangerを選択するモチベーションになっている。

# rangerからタブ/画面分割で開く

ranger-explorerからrangerを開いた時、Vimを開くキーバインドがrangerに自動で定義されるようにした。

```
<Ctrl-o>: 現在のタブ上で開く
<Ctrl-t>: 新しいタブで開く
<Ctrl-v>: 画面を垂直に分割して開く
<Ctrl-s>: 画面を水平に分割して開く
```

このようにrangerから分割して開くことが出来る。
![ranger経由で画面を分割して開く](https://i.gyazo.com/c4ce832cea5e7fcad3451fdfb21d03fd.gif)

動的にrangerへキーバインドを注入しているので、CLIからrangerを開いた時はこれらのキーバインドは使えず、ranger-explorerから開いた時のみタブや画面分割が出来るようになる。

また、動的にアサインするキーバインドは `~/.vimrc` で下記のように上書きできる。

```vim
let g:ranger_explorer_keymap_edit    = '<C-o>'
let g:ranger_explorer_keymap_tabedit = '<C-t>'
let g:ranger_explorer_keymap_split   = '<C-s>'
let g:ranger_explorer_keymap_vsplit  = '<C-v>'
```

# 得意なツールに任せる

無理に全てVimプラグインで頑張るよりも得意なツールを使えば良いと考えていて、
今回の場合はディレクトリ構造を扱うのが適したツールのrangerに任せている。

特にファイルを開いたり、検索する部分は外部のCLIツールを利用している。

* [fzf.vim](https://github.com/junegunn/fzf.vim/)
  * ファイル名をあいまい検索(fuzzy-finder)
* [ranger-explorer.vim](https://github.com/iberianpig/ranger-explorer.vim)
  * ディレクトリ階層からファイルを選択
* [tig-explorer.vim](https://github.com/iberianpig/tig-explorer.vim)
  * tigでGitの履歴から、`git grep`からファイルを開く

どれもプレビューが高速なツールなのでVimからファイルを探すワークフローが快適になった。

# 異なるツールの操作に一貫性を持たせる
Vimに外部ツールを利用する場合はパフォーマンスの利点もあるが、普段から使い慣れているツールを扱えるということが利点。
しかし、当然ながらツール毎に細かいキーバインドが異なる。同じ機能は同じキーバインドで扱えるようにしたいと思っていた。

そこで、fzfや以前愛用していたvimfiler/ctrlpと同様の使い勝手が欲しくて、`<C-o>`、`<C-t>`、`<C-v>`、`<C-s>`のキーバインドでタブや画面分割して開けるようにした。

プラグイン側からキーバインドを動的に設定するアイデアは、tig-explorerにも取り込んでいる。

前述の3つのツールは同じキーバインドで同じ振る舞いをするよう一貫性が保てるようになっているため、ツール別でキーバインドが合わずに混乱するのを防ぐことが出来ている。


