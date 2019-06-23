---
comments: true
date: 2018-07-15T00:05:21+09:00
description: ""
image: "https://i.gyazo.com/94f329bb2ad264a36c5ea67e1b548b99.png"
layout: post
published: true
tags:
  - "libinput"
  - "Linux"
title: タイピング中にタッチパッドを無効にする(Linux/Libinput)
---

タッチパッドに親指の付け根や手のひらが当たることでカーソルが飛び、頻繁にタイポが発生していた。  
今回、libinputの設定でカーソル飛びがほとんど無くなったので、その方法について書いた。

**記事内の環境**

- Distribution: elementary OS Loki (Ubuntu 16.04.1ベース)
- Kernel Linux 4.15.0-24-generic
- タッチパッドドライバでlibinputを使用している

ドライバはsynapticsとlibinputがあって、最近はwayland由来のlibinputの開発が盛んである  
また、X11でもライブラリをインストールすればラッパー経由でlibinputを利用できる

# libinputかsynapticsのどちらが有効か

判別方法は以下

```bash
$ xinput
⎡ Virtual core pointer                id=2  [master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer      id=4  [slave  pointer  (2)]
⎜   ↳ DLL075B:01 06CB:76AF Touchpad   id=11 [slave  pointer  (2)]
⎣ Virtual core keyboard               id=3  [master keyboard (2)]
    ↳ Virtual core XTEST keyboard     id=5  [slave  keyboard (3)]
    ↳ Power Button                    id=6  [slave  keyboard (3)]
    ↳ Video Bus                       id=7  [slave  keyboard (3)]
    ↳ Power Button                    id=8  [slave  keyboard (3)]
    ↳ Sleep Button                    id=9  [slave  keyboard (3)]
```

`Touchpad`の記述を含んだ行が見つかる。
```bash
DLL075B:01 06CB:76AF Touchpad   id=11
```

このTouchpadの`id`を引数として`xinput list-props 11`を実行。ドライバを通してタッチパッドの状態が見える

```bash
$ xinput list-props 11
Device 'DLL075B:01 06CB:76AF Touchpad':
        Device Enabled (140):   1
        Coordinate Transformation Matrix (142): 1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
        libinput Tapping Enabled (274): 1
        libinput Tapping Enabled Default (275): 0
        libinput Tapping Drag Enabled (276):    1
        libinput Tapping Drag Enabled Default (277):    1
        libinput Tapping Drag Lock Enabled (278):       0
        libinput Tapping Drag Lock Enabled Default (279):       0
        libinput Tapping Button Mapping Enabled (280):  1, 0
        libinput Tapping Button Mapping Default (281):  1, 0
        libinput Accel Speed (282):     -0.732877
        libinput Accel Speed Default (283):     0.000000
        libinput Natural Scrolling Enabled (284):       1
        libinput Natural Scrolling Enabled Default (285):       0
        libinput Send Events Modes Available (259):     1, 1
        libinput Send Events Mode Enabled (260):        0, 0
        libinput Send Events Mode Enabled Default (261):        0, 0
        libinput Left Handed Enabled (286):     0
        libinput Left Handed Enabled Default (287):     0
        libinput Scroll Methods Available (288):        1, 1, 0
        libinput Scroll Method Enabled (289):   1, 0, 0
        libinput Scroll Method Enabled Default (290):   1, 0, 0
        libinput Click Methods Available (291): 1, 1
        libinput Click Method Enabled (292):    1, 0
        libinput Click Method Enabled Default (293):    1, 0
        libinput Middle Emulation Enabled (294):        0
        libinput Middle Emulation Enabled Default (295):        0
        libinput Disable While Typing Enabled (296):    1
        libinput Disable While Typing Enabled Default (297):    1
        Device Node (262):      "/dev/input/event17"
        Device Product ID (263):        1739, 30383
        libinput Drag Lock Buttons (298):       <no items>
        libinput Horizontal Scroll Enabled (299):       1
```

libinput XXXXという行が続いているのでlibinputを利用している。
synapticsの場合はlibinputが利用されていない。


# libinputドライバを利用するように設定する

`/usr/share/X11/xorg.conf.d/` ディレクトリに数字+ドライバの設定ファイルが置かれている。  
ここの数字の中で大きいもが後に読み込まれるため、synapticsが優先的に利用されている



```bash
$ ls -l /usr/share/X11/xorg.conf.d/
合計 44
-rw-r--r-- 1 root root   92  6月 14 23:23 10-amdgpu.conf
-rw-r--r-- 1 root root 1099  7月  7  2017 10-evdev.conf
-rw-r--r-- 1 root root 1350  6月 15 02:26 10-quirks.conf
-rw-r--r-- 1 root root   92  6月 14 23:16 10-radeon.conf
-rw-r--r-- 1 root root  590  7月  7  2017 11-evdev-quirks.conf
-rw-r--r-- 1 root root  364  7月  7  2017 11-evdev-trackpoint.conf
-rw-r--r-- 1 root root  964  7月  7  2017 40-libinput.conf
-rw-r--r-- 1 root root  590  7月  7  2017 51-synaptics-quirks.conf
-rw-r--r-- 1 root root 1751  7月  7  2017 70-synaptics.conf
-rw-r--r-- 1 root root 2747  7月  7  2017 70-wacom.conf
```

libinputが40でsynapticsが70なのでsynapticsが優先されてしまう。
その場合は新しいファイルをdriverの読み込み優先度の高い`/etc/X11/xorg.conf.d/`に配置すれば良い。  
基本的に`/usr/share/X11/xorg.conf.d/` よりも個人の設定は`/etc/X11/xorg.conf.d/` に配置する。

新規作成したファイル`90-libinput.conf`を`/etc/X11/xorg.conf.d/`に追加した。 

```conf
Section "InputClass"
        Identifier "libinput pointer catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Option "Tapping" "True"
        Option "TappingDrag" "True"
        Option "DisableWhileTyping" "True"
        Driver "libinput"
EndSection
```

# DisableWhileTypingオプションでタイピング中にタッチパッドを無効にする

この`Option "DisableWhileTyping" "True"`が今回のキモ。
DisableWhileTypingはタイピング中にタッチパッドを無効にする機能。 

オプションはmanコマンドで確認出来る。
```
man libinput
```

```man
Option "DisableWhileTyping" "bool"
       Indicates  if the touchpad should be disabled while typing on the keyboard (this does not apply to modifier keys such as Ctrl or Alt).
```

CtrlやAltのような修飾キー以外に対して有効になる。

この機能のお陰でカーソルが移動したり誤タップが無くなった。
