---
layout: post
title: "自動でコミットメッセージの先頭にIssueIDを付与する"
published: true
date: 2015-08-18
comments: true
categories: git
tags:
   - ruby
   - pivotaltracker
image: https://i.gyazo.com/abfa076d4f3affdf717d87351b8ca5fe.png
---

なぜこんなことがやりたいかというと、

* スクラムでのタスク管理にPivotalTracker(http://www.pivotaltracker.com)を利用していて、ストーリーと呼ばれるチケットにはIDが付与される
* Githubと連携することができ、[#IDの番号]としてコミットメッセージを入れてPushすると、PivotalTrackerのコメント欄にGithubのリンクが自動で挿入される
* あとからコミットログを追うときにコミットメッセージにIDが入っていると該当のチケットを検索できる
* 毎回IDを入れるのがめんどくさい、たまに忘れる
* チームで浸透させたい

<!--more-->

という理由から。  


## Gitのhookを利用する

プロジェクトのルートディレクトリから辿ると、`.git/hook/`というディレクトリがある  
hookの中にはpre-commit, prepare-commit-msg, commit-msgなど、いろんなスクリプトが準備されている  
(どれも`.sample`という名前で入っているはず)

hookの順序としては下記のタイミングで実行される  
> 1. commit コマンド
> 2. pre-commitスクリプト実行
> 3. デフォルトのログメッセージの準備
> 4. prepare-commit-msgスクリプト実行
> 5. コミットメッセージ入力用のエディタ起動
> 6. commit-msgスクリプト実行
> 7. コミットの作成
> 8. post-commitスクリプト実行
> 9. --amendで実行した場合はpost-rewriteスクリプト実行


ということで、commit-msgにコミットメッセージの先頭に自動で追記するRuby scriptを書く

## commit-msg
{{< gist iberianpig f010cfa1134bc19e3989 >}}

### 処理の流れ
1. `ARGV[0]`にはコミットメッセージを入力するファイルが与えられる
* ファイルからコメントを取り出す
* コメントから先頭の[#xxxx]を除去する(`git commit -amend`した時のため)
* コメントから空行、#で始まる行を除去する(ただし、`-- >8 --`マークは残す)  
  * `git commit -v` の際に、`-- >8 --`マーク以下にCommit時に自動で切り取られるDiff表示があるため
* メッセージが`-- >8 --`マークから開始だった場合、commitメッセージが空であるとして、コミットを中断
* `git branch`コマンドより、* の付いているカレントブランチIssueID_xxxxからIssueIDを抽出する
* IssueIDとコメントを連結させる
* メッセージをファイルに書き込んで終了

### 実行権限の付与

作成したスクリプトに下記コマンドで実行権をつけてやる
```
$ chmod +x commit-msg
```

### やってみる
ブランチを切ってみる  
```
git co -b "12345_xxxxxx"
```

適当にコミットしてみる  
```
git commit -am "hoge fuga"
```

コミットメッセージが`[#12345]hoge fuga`となっているはず。  

`git commit -amend`などでもうまく動くはず。  


## その他チラ裏

`prepare-commit-msg`では、`git commit -ammend`の際に二重で[#IssueID]を付与してしまうためcommit-msgを利用した  
shell scriptでsedを利用していたが、GNUのsedとFreeBSD系のsedの動作が異なり、他のメンバーに展開できなかったためRubyで書いた

## エンジニアの小さなしあわせ

こういう小さな生産性向上のためにいろいろ小手先を使うのが好き。  
エンジニアならこの感覚、大事。  
ハマると仕事がつかなくなるんだけれども。  

## Special Thanks
(http://qiita.com/mima_ita/items/dcaa3789022d2a9ab929)
