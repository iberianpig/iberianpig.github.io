---
layout: post
title: "tig-explorer.vimの使い方"
draft: false
date: 2019-04-30T23:57:45+09:00
comments: true
tags: 
   - vim
   - git
image: "https://i.gyazo.com/181fef546cced7ca6dc651dff59cd1bf.gif"
description: "tig-explorer.vimの使い方。vimとgitクライアントのtigを行き来出来るvimプラグイン。"
---

# Vim用のGitクライアントが欲しかった
vimのGitプラグインとして何を使っているのが多いだろうか？  
自分の観測範囲では[fugitive](https://github.com/tpope/vim-fugitive)を使っている人が多いようだ。

しかし、ターミナルではCUIツールで高速なプレビューの出来る`tig`をGitクライアントとして利用している人は多いのではないだろうか。

<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://iberianpig.dev/posts/2016-04-22-tig%25E3%2582%2592%25E4%25BD%25BF%25E3%2581%2586/" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fiberianpig.github.io%2Fposts%2F2016-04-22-tig%25E3%2582%2592%25E4%25BD%25BF%25E3%2581%2586%2F&amp;key=f073c4f447189e73167146bd9d0f6195&amp;iframe=card-small"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

vimでもtigが使いたい。そんな人(自分)のためにvim pluginを作成した。

# tig-explorer.vim

<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://github.com/iberianpig/tig-explorer.vim" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fgithub.com%2Fiberianpig%2Ftig-explorer.vim&amp;key=f073c4f447189e73167146bd9d0f6195"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

[tig-explorer.vim](https://github.com/iberianpig/tig-explorer.vim)は`tig`をvimから扱うプラグイン。

`tig`の機能でdiff上から`e`キーを押下すると任意のエディタで該当箇所を開く事が出来るが、このプラグインを使うと、vimから`tig`を呼び出すことが出来る。

[![Image from Gyazo](https://i.gyazo.com/181fef546cced7ca6dc651dff59cd1bf.gif)](https://gyazo.com/181fef546cced7ca6dc651dff59cd1bf)

`tig`を開き、差分をチェックして、そこから再びvimで開くことが出来る。

また、`vim`から`tig`を呼び出すには`!tig`コマンドをvimのコマンドモードから呼び出すことでも同じことが実現でも可能だが、
プロセスが`vim`-`tig`-`vim`-`tig`-`vim`のようにどんどんネストしてしまう。

このプラグインを経由してエディタで開く場合は親のvimプロセスで開くため、vim上のbuffer移動やhistory、yankが途切れることがない。

また、vimから`tig`に行番号やファイル名を渡せるので、↓のコマンドが格段に扱いやすくなる。

* `tig FILEPATH`で閲覧中のファイルの履歴を見る(`:TigOpenCurrentFile`)

* `tig grep PATTERN PATH`でプレビューしてから開く(`:TigGrep`)

* `tig blame FILEPATH`で現在のファイル履歴を行単位で見る(`:TigBlame`)

# tig-explorer.vimのカスタマイズ

.vimrcの記述例

```vim
" tigを開く
nnoremap <Leader>t :TigOpenProjectRootDir<CR>

" 現在のファイルの履歴を見る
nnoremap <Leader>T :TigOpenCurrentFile<CR>

" パターンでtig grepする
nnoremap <Leader>g :TigGrep<CR>

" tig grepした内容を再呼び出しする
nnoremap <Leader>r :TigGrepResume<CR>

" 選択中のキーワードでtig grepする
vnoremap <Leader>g y:TigGrep<Space><C-R>"<CR>

" カーソル下のキーワードでtig grepする
nnoremap <Leader>cg :<C-u>:TigGrep<Space><C-R><C-W><CR>

" 現在のカーソル位置でtig blameする
nnoremap <Leader>b :TigBlame<CR>
```


また、このプラグインの特徴的なところでtig上で`Ctrl-t`を押下するとvimのタブで開く機能が追加されている。
同様に`Ctrl-s`で水平分割、 `Ctrl-v`で垂直分割出来る。

[![Image from Gyazo](https://i.gyazo.com/1cb632c8930079dd3168d3ecc8507ee1.gif)](https://gyazo.com/1cb632c8930079dd3168d3ecc8507ee1)

`tig`上のvimを開くキーバインドの動的に追加していて、下記がデフォルトの設定値。

```vim
let g:tig_explorer_keymap_edit    = '<C-o>'
let g:tig_explorer_keymap_tabedit = '<C-t>'
let g:tig_explorer_keymap_split   = '<C-s>'
let g:tig_explorer_keymap_vsplit  = '<C-v>'
```
↑ `.vimrc`上で`tig-explorer.vim`から開いた際にのみ利用可能なキーバインドが定義できる

# 得意な専任のCUIツールに任せる

なんでもvimにやらせようとするのではなく、専任のツールにまかせてしまえばCUIでもVimでも操作感は変わらず、vimに任せるよりも体験が良い場合が多々ある。

同じコンセプトでranger-explorer.vimというrangerをデフォルトファイラとして扱うvimプラグインもあるのでぜひ試してみて欲しい。

<div class="iframely-embed"><div class="iframely-responsive" style="height: 140px; padding-bottom: 0;"><a href="https://github.com/iberianpig/ranger-explorer.vim" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fgithub.com%2Fiberianpig%2Franger-explorer.vim&amp;key=f073c4f447189e73167146bd9d0f6195"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

<div class="iframely-embed"><div class="iframely-responsive" style="padding-bottom: 69.5441%; padding-top: 120px;"><a href="https://iberianpig.dev/posts/2018-09-02_make_ranger-explorer.vim/" data-iframely-url="//cdn.iframe.ly/api/iframe?url=https%3A%2F%2Fiberianpig.github.io%2Fposts%2F2018-09-02_make_ranger-explorer.vim%2F&amp;key=f073c4f447189e73167146bd9d0f6195"></a></div></div><script async src="//cdn.iframe.ly/embed.js" charset="utf-8"></script>

