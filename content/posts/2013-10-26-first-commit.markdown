---
layout: post
title: "Linux版SublmeTextでの日本語入力"
date: 2013-10-26
comments: true
categories: Linux
tags:
  - SublimeText
  - Octopress
---


# Linux + Octpress + Sublime Text 2 + SublimeIbus

SublimeTextはデフォルトで日本語入力は対応してない。
調べてみるとLinuxでSublmeTextでの日本語入力は鬼門のようだ。
<!-- more -->
InputHelperなるものを使ってはみたものの、ショートカットキーからダイアログが出て来るタイプで、プログラムのコメント程度なら許容できるが、常用するにはツラミがある。

ブログもSublimeTextで書きたかったので調べを尽くした。
何とかヨサゲなソリューションを発見したので残しておく。

# SublimeIbus(https://github.com/chikatoike/SublimeIBus)


    対象となる利用者

      * Linux の Sublime Text 2 で日本語入力したい人
      * InputHelper による日本語入力に不満を持っている人
      * iBusを利用している人


まさに。求めていたもの。

` SCIM、uim、その他のIMには対応していません。`とあるものの自分はibus-mozc 使ってるのでOK


## 若干課題は残る

   * たまに日本語入力変換窓が迷子に
   * なぜかDeleteが動かない（日本語入力時）
   * SublimeIbusからSlowなんとかいうワーニングが出る（スクリーンショット撮り忘れた）

良いソリューションは無いのか
