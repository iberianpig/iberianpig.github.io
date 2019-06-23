---
layout: post
title: "send data on Intent to call activity"
published: true
date: 2014-07-23
comments: true
tags: 
  - android
---

#Activityとは
## Androidの画面単位の概念
一つのアクティビティに対してクラス一つが割り当てされる  
  -->1つのXML(Viewテンプレート)と1つのJavaクラス(Activity)が必要となる


#Intentとは

> インテントというのは簡単に言えばアクティビティなどが他のアクティビティやアプリケーションなどと情報のやり取りを行うための箱のようなものです。インテントという箱には、相手先や届けたい情報などが含まれています。

> アクティビティから他の指定したアクティビティへインテントを送ることがあります。例えば他の画面を表示したい場合などです。  

(参考:　http://www.javadrive.jp/android/intent/index1.html)  

<!-- more -->

##暗黙的インテントと明示的インテント
 
> どの機能を呼び出すかをあらかじめ指定して直接それを起動することを「明示的インテント」(explicit intent)、何をしたいかは明示せずに漠然とそのデータに対して実行できる機能の一覧を要求することを「暗黙的インテント」(implicit intent)という。

(参考: http://e-words.jp/w/E382A4E383B3E38386E383B3E38388.html)


##どうやって起動するのか

> **インテント**の**アクション**とは、あるオブジェクトが他のオブジェクトを起動する際に、何をしたいのかを指すための指定です。ここでいうオブジェクトはActivityやサービスのことを指します。

> アクションを指定するには、Intentクラスのコンストラクタで指定するか、もしくはIntentクラスのsetActionメソッドを使って指定します。### また、指定するアクションはすべてIntentクラスの遷移元への値の渡し方と受け取り方定数として定義されていますので、該当な定数を使ってアクションを以下のように指定します。


``` java activity.java

// アクションを指定してインテントのインスタンス生成
Intent intent = new Intent(Intent.ACTION_MAIN);

// 次画面のアクティビティ起動
startActivity(intent);
```
    
インテントを**new Intent**してそれを**startActivity()**の引数に入れて起動するらしい。

### StartActivityとは
同一アプリ内の画面を呼び出すときは**明示的Intent**を作成する。そして**startActivity()**の引数として引き渡すことでそれを実現する。ただし、この挙動は一方通行のようなもの。呼び出し元の情報を返して欲しいときは**startActivityForResult()**を使う。
  
> また、アクションには「**アクティビティアクション**」と「**ブロードキャストアクション**」があります。   



###アクティビティアクション
>**アクティビティアクション**とは、他のアクティビティを起動する際に、何をしたいのかを示すためのアクションです。具体的には以下のものがあります

|アクション|機能
|:-----------|:------------
|ACTION_MAIN |メインエントリーポイントとしてアクションを起動する。データを戻すことができない。
|ACTION_VIEW |データをユーザに表示するためにアクションを起動する。
|ACTION_ATTACH_DATA |別の場所にデータが添付されていることを示す。
|ACTION_EDIT |データを編集するためにアクションを起動する。
|ACTION_PICK |データの中からアイテムを選択するためにアクションを起動する。選択されたアイテムを受け取る。
|ACTION_CHOOSER |起動するActivityを選択するチューザーをユーザに示し、選択してもらう。
|ACTION_GET_CONTENT |指定した種類のデータをユーザに選択、もしくは作成してもらう。
|ACTION_DIAL |データで指定した番号を電話番号として設定する。データを指定しなければ、ユーザがその場で設定する。電話をかける操作はユーザに任せる。
|ACTION_CALL |データで指定した人に電話をかける。データを指定しなければ、ユーザがその場で指定した番号に電話をかける。
|ACTION_SEND |別の人にデータを送信する。データの宛先は指定しない。このIntentを受け取ったアクションが、ユーザに宛先を問う。
|ACTION_SENDTO |データによって指定された人にメッセージを送信する。
|ACTION_ANSWER |かかってきた電話に対処するアクションを起動する。
|ACTION_INSERT |データに含まれるURIが示すディレクトリに秋のデータを挿入する。
|ACTION_DELETE |データに含まれるURIが示すデータをコンテナから削除する。
|ACTION_RUN |データを起動する。その意味はデータの種類によって異なる。
|ACTION_SYNC |データの同期を実行する。
|ACTION_PICK_ACTIVITY |Intentが与えられるActivityを選択し、そのクラスを返す。
|ACTION_SEARCH |検索を実行する。
|ACTION_WEB_SEARCH |WEB検索を実行する。
|ACTION_FACTORY_TEST |デバイスが工場検査モードで起動する際にだけ実行される工場検査のメインエントリポイントとして起動する。

### ブロードキャストアクション
> ブロードキャストアクションとは、なんらかのイベントが発生したことを他のオブジェクトに知らせる際に指定するアクションです。

|アクション|機能
|:-----------|:------------ 
|ACTION_BATTERY_CHANGED |充電中かどうかや、電池残量が変わった時に送られる。
|ACTION_BATTERY_LOW |電池残量が少なくなった場合に送られる。
|ACTION_BOOT_COMPLETED |システムの起動が完了したことを示す。
|ACTION_PACKAGE_ADDED |新しいアプリケーションパケージがつかされたことを示す。
|ACTION_PACKAGE_CHANGED |存在するアプリケーションのパケージが変更されたことを示す。
|ACTION_PACKAGE_REMOVED |アプリケーションパケージを削除したことを示す。
|ACTION_TIMEZONE_CHANGED |タイムゾーンが変更されたことを示す。
|ACTION_TIME_CHANGED |時刻が変更されたことを示す。
|ACTION_TIME_TICK |現在時刻が変わった時に毎分送られるアクション。
|ACTION_HEADSET_PLUG |ハンドセットのプラグが抜き差しされたことを示す。

(参考:　http://it-trick-java.appspot.com/android/c3152/page7212.html)


## Intentに値・メッセージを乗っけて呼び出し先アクティビティに引き渡す

Activity呼び出す際に`setStart(intent)`とするが、そのintentの中身に仕込む。  


> 遷移先のActivityを指定してIntentを作成し、『startActivity()』メソッドにてActivityを開始します。  
その際、Activityを開始させる前にIntentへ値を保持させる事で、遷移先へ値を渡す事が可能です。  
遷移先では、渡されてきた値を受け取るというよりも、起動に利用されたIntentの中にある値を取得するイメージです。  
Intentを値の一時保管場所として、値を保持出来れば遷移先からもIntent内の値を取得する事が出来るといった考え方です。 
> Intentへ値を保持させるには『putExtra()』メソッドを使用しましょう。

(参考: http://web-terminal.blogspot.jp/2013/06/android.html#How-to-receive-and-how-to-pass-a-value-to-a-transition-destination)


### 遷移先へ値を渡す
`intent.putExtra(key, val)`でインテントに値を保持させることができる。

    // 遷移先のactivityを指定してintentを作成
    Intent intent = new Intent( this, MyActivity.class );
    // intentにkey, valueをセット
    intent.putExtra( "key", "value" );
    // 指定のActivityを開始
    startActivity( intent );
    
### 遷移先で値を取得する

`val = intent.getStringExtra(key)`で保持させた値を取得することができる

    // 現在のintentを取得する
    Intent intent = getIntent();
    // intentから指定キーの文字列を取得する
    String name = intent.getStringExtra( "key" );
    
getIntent()でintentを取得。
intent.getStringExtra()で指定したキーに対となる値を取得できる。

##### 型指定での取得
今回保持していた値は"value"というString型だったため、getStringExtraとなった。
格納時の方によって呼び出し方は異なる。

|型|取得メソッド名
|:-----------|:------------
|真偽値の配列（boolean[]) |getBooleanArrayExtra( "キー" )
|真偽値(boolean) |getBooleanExtra( "キー" , デフォルト値 )
|バンドル(Bundle) |getBundleExtra( "キー" )
|バイト配列(byte[]) |getByteArrayExtra( "キー" )
|バイト(byte) |getByteExtra( "キー" , デフォルト値 )
|文字配列(char[]) |getCharArrayExtra( "キー" )
|文字(char) |getCharExtra( "キー" , デフォルト値 )
|文字シーケンス配列(CharSequence[]) |getCharSequenceArrayExtra( "キー" )
|文字シーケンスの配列（ArrayList) |getCharSequenceArrayListExtra( "キー" )
|文字シーケンス(CharSequence) |getCharSequenceExtra( "キー" )
|浮動小数点数配列(double[]) |getDoubleArrayExtra( "キー" )
|浮動小数点数(double) |getDoubleExtra( "キー" , デフォルト値 )
|浮動小数点数配列(float[]) |getFloatArrayExtra( "キー" )
|浮動小数点数(float) |getFloatExtra( "キー" , デフォルト値 )
|整数配列(int[]) |getIntArrayExtra( "キー" )
|整数(int) |getIntExtra( "キー" , デフォルト値 )
|整数オブジェクトの配列(ArrayList) |getIntegerArrayListExtra( "キー" )
|整数配列(long[]) |getLongArrayExtra( "キー" )
|整数(long) |getLongExtra( "キー" , デフォルト値 )
|オブジェクトの一時的保管領域配列(Parcelable[]) |getParcelableArrayExtra( "キー" )
|オブジェクトの一時的保管領域配列( ArrayList) |getParcelableArrayListExtra( "キー" )
|オブジェクトの一時的保管領域( T) |getParcelableExtra( "キー" )
|シリアライズ(Serializable) |getSerializableExtra( "キー" )
|整数配列(short[]) |getShortArrayExtra( "キー" )
|整数(short) |getShortExtra( "キー" , デフォルト値 )
|文字列配列(String[]) |getStringArrayExtra( "キー" )
|文字列配列(ArrayList) |getStringArrayListExtra( "キー" )
|文字列(String) |getStringExtra( "キー" )

> 全て添え字指定にて値を識別し、取得しますが
該当する添え字が無い場合、基本的にはnullが返却されます。
上記一覧内のメソッドの中には、第二引数にデフォルト値を指定出来るものがあり、
そのようなメソッドでは、キーに該当するものが無い場合はデフォルト値が返却されます。
もちろん、第二引数に指定するデフォルト値も、メソッドに該当する型である必要があります。

(参考: http://web-terminal.blogspot.jp/2013/06/android.html)

## 遷移先でセットした値を遷移元で受け取る
今度は遷移元への値の戻し方。

### 遷移元での事前準備
Activityはfinish()で終了を行うことができる
前述の通り、呼び出し時にstartActivityForResult()を宣言した時のみ呼び出し元に呼び出し先の結果を戻す事が可能となる

    // 遷移先のactivityを指定してintentを作成
    Intent intent = new Intent( this, MyActivity.class );
    // 遷移先から返却されてくる際の識別コード
    int requestCode = 1001;
    // 返却値を考慮したActivityの起動を行う
    startActivityForResult( intent, requestCode );
    
### 遷移元で値を受け取るメソッド

遷移先のアクティビティが破棄されたイベントをトリガーに発火する onActivityResult() をコールバックで実装する

    public void onActivityResult( int requestCode, int resultCode, Intent intent )
    {
     // startActivityForResult()の際に指定した識別コードとの比較
     if( requestCode == 1001 ){
     
      // 返却結果ステータスとの比較
      if( resultCode == Activity.RESULT_OK ){
     
       // 返却されてきたintentから値を取り出す
       String str = intent.getStringExtra( "key" );
      }
     }
    }

下記をチェックしています。

* requestCodeが最初にセットした値通りか。
* 返却結果ステータスがOKか（またはキャンセルか、などなど）

これらが正しければ、getStringExtra()を使って文字列を取得する。


### 遷移先での遷移元に戻す値のセット

finish();した時にどんな値を遷移元に戻すか
    // intentの作成
    Intent intent = new Intent();
     
    // intentへ値を保持させる
    intent.putExtra( "key", "result_val" );
     
    // 戻したい結果ステータスをセットする
    setResult( Activity.RESULT_OK, intent );
     
    // アクティビティを終了させる
    finish();
    
`new Intent`して、`putExtra(key,val)`で値を保持して、うまく行ったかどうかのステータスを`setResult()`でセットする。そして、`finish()`する、という流れ。
遷移先に値を引き渡すのと同様、`putExtra(key,val)`を使っている。

setResultでRESULT_OKをセットしているので、これで呼び出し元で正しく受け取れる。
独自でハンドルするときはここは独自定数で変更できそう。
