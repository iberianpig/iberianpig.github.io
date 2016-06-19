---
layout: post
title: "Octopressで下書き保存をデフォルト設定にする方法"
date: 2014-01-22
comments: true
categories: Octopress
published: true
---


# Octopressでの下書き保存
普通にdeployすると、`rake new_post['hogehoge']`で生成された`/_posts`配下の記事がすべてPublishされてしまう。
<!-- more -->
## 一時的に手元にとどめておくためには

Octopressデフォルトのプラグインがあるので、記事のファイルに『下書き』であることを明示させればよい。

実際は`yyyy-MM-dd-[$title].markdown`内に `published: false`を記述するだけ。
(※$titleは生成された記事毎に異なります)

```diff
  layout: post
  title: "Octopressで下書き保存をデフォルト設定にする方法"
  date: 2014-01-22
  comments: true
  categories:
+ published: false
```

一番下の`published: false`を追記。

これでrake deployしてもpublishされないため、投稿する場合はfalseをtrueに変える必要がある。


# 下書き保存をデフォルト設定

記事生成時に下書き保存をデフォルトで設定してほしい場合、RakeFileを編集する。

```diff
task :new_post, :title do |t, args|
  if args.title
    title = args.title
  else
    title = get_stdin("Enter a title for your post: ")
  end
  raise "### You haven't set anything up yet. First run `rake install` to set up an Octopress theme." unless File.directory?(source_dir)
  mkdir_p "#{source_dir}/#{posts_dir}"
  filename = "#{source_dir}/#{posts_dir}/#{Time.now.strftime('%Y-%m-%d')}-#{title.to_url}.#{new_post_ext}"
  if File.exist?(filename)
    abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
  end
  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts "---"
    post.puts "layout: post"
    post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
    post.puts "date: #{Time.now.strftime('%Y-%m-%d %H:%M')}"
    post.puts "comments: true"
    post.puts "categories: "
+    post.puts "published: false"
    post.puts "---"
  end
end
```

`task :new_post,`で始まるブロック内に`post.puts "published: false"`の行を`post.puts "---"` で囲われるように追記。

これでRake new_postが呼ばれた時点で`published: false`が入った状態で記事を生成するようになる。

