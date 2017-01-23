---
categories: "hugo"
comments: true
date: 2017-01-23T19:36:53+09:00
image: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Gnu-bash-logo.svg/1280px-Gnu-bash-logo.svg.png"
layout: post
published: true
tags:
- "shellscript"
title: "簡単にHugoのブログポストのテンプレを生成するシェルスクリプトを作った"
---

表題の通り。
いつもコマンドを忘れるので。
ちなみにデプロイもシェルスクリプトで書いてる。


# hugoの記事作成

```bash
hugo new "path/to/article.md"
```

コレだけなのだが、記事ソースが配置される`content`配下に`post`と階層が有る場合、
`hugo new "content/post/article.md"`とやってしまう。

しかし`content/content/path/to/article.md`に作られてしまう。

正しくは`hugo new "post/article.md"`だ。`content`を**除いて**おく必要が有る。  

「久々にブログ書くか」という時（いつも）こうなる。しんどい。  

# shellscriptで生成を自動化

ということで自動化しよう。
shellscriptを書く。`new_post.sh`と言う名前にした。

```bash
#!/bin/bash

echo -e "\033[0;32mCreating new post...\033[0m"

if [ $# -eq 1 ]; then
  title="_$1"
else
  title=""
fi

formatted_date=$(date "+%Y-%m-%d")

full_path="posts/${formatted_date}${title}.md" 

hugo new "$full_path"

vi "content/$full_path"
```

タイトルに日付を付けてエディタを起動するまで自動化した。  
```bash
./new_post.sh title
```

で`./content/posts/2017-01-23_title.md`が生成されてviで開く。

これでブログ書き出しの障壁が小さくなった。もっと頻度を上げたい。  

ちなみにbashのlintとしてshellcheckを入れてる。  
さらにVimのWatchdogsに組み込んで使うと、非同期でチェックを行い、警告を出してくれて大変便利。  
変な書き方すると怒ってくれて、自分のような半端者にはたいへん助かる。  
使ってない人はぜひインストールしよう。


