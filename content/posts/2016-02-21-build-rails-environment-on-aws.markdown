---
layout: post
title: "build rails environment on AWS"
published: false
date: 2016-02-21
comments: true
tags: 
categories: aws
---

# AWS上でUbuntu14.04, Rails4を利用して環境設定する

Ubuntu14.04を選択するのは普段利用しているラップトップの開発環境と同等のため。特にそれ以上の意味はない。

1. AWSコンソールでインスタンス作成する
  * セキュリティグループ設定では*自分のIPアドレス(グローバル), sshのため22番ポートを許可しておく*
  * pemキーをダウンロード, ローカルPC上`/home/LOCAL_USERNAME/.ssh/`に配置
* インスタンスが起動したら、コンソール上で接続を選択、、Wizardの指示に従い、デフォルトユーザ(ubuntu)でssh接続(上記pemを利用)
  * ユーザを作成する
  ```
  sudo adduser USERNAME
  ```
  * ユーザにsudoを使えるようにさせる
  ```
  sudo gpasswd -a USERNAME sudo
  ```
  * defaultエディタをnanoからvimに変更する
   ```
   sudo update-alternatives --config editor
   ``` 
  * 作成したユーザにスイッチする
  ```
  sudo su -l USERNAME
  ```
  * sshでログインできるように設定する
  ```
  mkdir ~/.ssh
  chmod 700 ~/.ssh/
  touch ~/.ssh/authorized_keys
  chmod 644 ~/.ssh/authorized_keys
  ```

  * インスタンス作成時にダウンロードしたpem使って公開鍵を取得
     * ローカルマシン上で `ssh-keygen -y`
     * `/path/to/pemkey.pem を指定`
     * 出力された結果( public key)をコピーしてAWSインスタンス上の`/home/USERNAME/.ssh/authorized_keys`にペーストする

    6  sudo su -l USERNAME
    7  exit
    8  visudo
    9  sudo visudo
   10  vi .bashrc
   11  sudo update-alternatives --config editor
   12  visudo
   13  sudo visudo
   14  users
   15  users -h
   16  users --help
   17  man useradd
   18  useradd -G
   19  useradd -G admin
   20  useradd -g admin
   21  useradd -g ubuntu  admin
   22  cat /etc/passwd
   23  groups
   24  cat /etc/group
   25  sudo gpasswd -a USERNAME sudo
   26  cat /etc/group
   27  exit
   28  history

インスタンス作成時にダウンロードしたPEM使って公開鍵を取得
 ローカルマシン上で `ssh-keygen -y`
 /path/to/pemkey.pem を指定
 public_keyをコピーしてAWS上の/home/USERNAME/.ssh/authorized_keysにペーストする



    1  ll
    2  mkdir .ssh
    3  chmod 700 .ssh/
    4  ll
    5  touch .ssh/authorized_keys
    6  chmod 644 .ssh/authorized_keys
    7  exit
    8  cd .ssh/
    9  vi authorized_keys
   10  ll
   11  ls
   12  exit
   13  vim
   14  vim --versions
   15  vim --version
   16  git
   17  git st
   18  sudo apt-get install git
   19  sudo su -l ubuntu
   20  sudo apt-get install git
   21  exit
   22  sudo apt-get install git
   23  git clone git@github.com:USERNAME/dotfiles.git
   24  ls
   25  git st
   26  git clone https://github.com/USERNAME/dotfiles.git
   27  cd dotfiles/
   28  ls
   29  vi dotfilesLink.sh
   30  sh dotfilesLink.sh
   31  ls
   32  ls -lsa
   33  cd
   34  vim
   35  curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
   36  ls
   37  sh ./install.sh
   38  vim
   39  ll
   40  ll
   41  ls
   42  source  ~/.bashrc
   43  cd
   44  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
   45  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
   46  rbenv
   47  rbenv --version
   48  rbenv install --list
   49  rbenv install ruby-2.3.0
   50  rbenv install 2.3.0
   51  sudo apt-get update
   52  apg
   53  sudo apt-get install apt-fast
   54  vi ~/.bashrc
   55  vi ~/.bash_profile
   56  vi ~/.bash_aliases
   57  source  ~/.bashrc
   58  apg
   59  sudo apt-get update
   60  sudo apt-get upgrade
   61  sudo apt-get install -y libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev
   62  sudo apt-get install -y libreadline-dev
   63  rbenv install 2.3.0
   64  source ~/.bashrc
   65  source ~/.bash_profile
   66  source ~/.bash_aliases
   67  make
   68  sudo apt-get install -y make
   69  sudo apt-get install -y g++
   70  sudo apt-get install -y libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev libreadline-dev libxslt-dev libxml2-dev libsqlite3-dev
   71  source  ~/.bashrc
   72  rbenv install 2.3.0
   73  ll
   74  ruby -v
   75  rbenv global
   76  rbenv rehash
   77  rbenv global
   78  rbenv global 2.3.0
   79  rbenv global
   80  rbenv rehash
   81  ll
   82  mkdir -p /var/www/makrsjp
   83  sudo mkdir -p /var/www/makrsjp
   84  ll
   85  cd /var/www/
   86  ll
   87  sudo mv makrsjp makersjp
   88  cd /var/www/makersjp/
   89  ls
   90  cd ..
   91  ll
   92  pwd
   93  history
i
