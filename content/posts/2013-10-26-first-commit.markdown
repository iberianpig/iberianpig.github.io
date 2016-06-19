---
layout: post
title: "first commit"
date: 2013-10-26
comments: true
categories: Linux SublimeText Octopress
---


# Linux + Octpress + Sublime Text 2 + SublimeIbus



ちょっと前からSublimeText使ってたんだけど、デフォルトで対応してないからかLinuxでの日本語入力がめんどくさい。

LinuxでSublmeTextでJapaneseは鬼門のようだ。
<!-- more -->
InputHelperなるものを使ってはみたものの、ショートカットキーからダイアログが出て来るタイプで、プログラムのコメント程度なら許容できるものの、萎える。非常に萎える。

そのくせブログもSublimeTextでやろうという湧いて出る謎のチャレンジャー精神は何なんだ。

しかしながら何とかヨサゲなソリューションを発見したので残しておく。

SublimeIbus(https://github.com/chikatoike/SublimeIBus)


Readmeを見ているとこんな記述が。

    対象となる利用者

      * Linux の Sublime Text 2 で日本語入力したい人
      * InputHelper による日本語入力に不満を持っている人
      * iBusを利用している人

おお、神よ！まさにこれっす！


` SCIM、uim、その他のIMには対応していません。` とあるものの自分はibus-mozc 使ってるのでOK


## ->Linux版SublimeTextは日本語に難があり、SubimeIbusがオススメ



### 若干課題あり。

   * たまに日本語入力変換窓が迷子に
   * なぜかDeleteが動かない（日本語入力時）
   * SublimeIbusからSlowなんとかいうワーニングが出る（スクリーンショット撮り忘れた）

しかしながら、SublimeIbus使ってとりあえず日本語打てるようになったのでまずはよしとしますか。