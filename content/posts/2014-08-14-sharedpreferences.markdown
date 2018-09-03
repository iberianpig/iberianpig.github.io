---
layout: post
title: "Androidでのデータの保存"
date: 2014-08-14
comments: true
tags: 
  - SharedPreferences 
categories: android
---


# データの保存

## SharedPreferenceの利用

> Androidアプリでデータを保存する方法のひとつ
> データをキーと値の組み合わせで保存
> ファイルなどに保存するよりも非常に簡単にデータを保存可能

ただし大規模なデータには向かず、設定項目向き。

<!-- more -->

### 使い方

> SharedPreferences はgetSharedPreferences(String name, int mode);
> でを取得。
> `name` は `Preference` 自体の名前指定
> mode には
> `Activity.MODE_PRIVATE`
> `Activity.MODE_WORLD_READABLE`
> `Activity.MODE_WORLD_WRITEABLE`
> などを指定

モードについては後述。

`SharedPreferences pref = getSharedPreferences(PREF_NAME, MODE_PRIVATE);`

SharedPreferencesのインスタンスをgetSharedPreferencesで取得し、
editメソッドでEditorクラスのインスタンスを呼び出す。
そのEditorクラスにputXxxxメソッドを使って値を対応させる
最後にcommitメソッドで格納する

``` java
// プリファレンスに保存
Editor editor = pref.edit();
editor.putString(KEY_TEXT, s);  // KEY, VALUEの組み合わせで保存
editor.commit();
```

### 保存される場所
> 保存された Preference は data/data/パッケージ名/shared_prefs
> の中に xmlファイルとして保存される

### データの取得

`getXxxx(String key, Xxxx defValue)`のkey, value形式で取得する。

``` java 
getString(String key, String defValue);
getInt(String key, int defValue);
getLong(String key, long defValue);
```

### データ型

> 下記のデータ型がXMLに保存される
> 1. boolean
> 2. float
> 3. int
> 4. long
> 5. String

※ データの大きい物、objectの保管は非推奨。(シリアライズさせれば出来るはず)  
それらはバイナリ化してDBへ、もしくはファイルとして保存させるべき。

### MODE種別

プリファレンスでは、MODE_APPENDを除いた3種類のオペレーションモードが指定可能

|定数  |説明|
|-------|----|
|MODE_PRIVATE  |作成したアプリのみ読み書きできる
|MODE_WORLD_READABLE  |他アプリに読み込み権を与える
|MODE_WORLD_WRITEABLE  |他アプリに書き込み権を与える


### どのタイミングで使用すべきか

実際は下記が一般的とのこと。

* 書き込み
    * onStop()
* 読み込み
    * onResume()



[ サンプルコード ]( https://gist.github.com/iberianpig/a25ce9e12795cdd40dd1/revisions )


## ファイル入出力

openFileOutput, openFileInputを利用してローカルファイルへ保存。
android.content.Contextのファイル書き込み/読み込み系のメソッドを利用。


###ファイル入出力メソッド

|メソッド名|  概要|
|---------|------|
|openFileInput(String name)|  ローカルファイルの読み込み|
|openFileOutput (String name, int mode)|  ローカルファイルへの書き込み|
|deleteFile(String name)|  ローカルファイルの削除|
|abstract String[]fileList()|  該当アプリが作成したローカルファイルのリストを取得|

### モード種別

|定数  |説明|
|-------|----|
|MODE_APPEND| 既にファイルがあった場合、追記で開く|
|MODE_PRIVATE| 他のアプリからアクセスできないprivate fileとして生成|
|MODE_WORLD_READABLE| 他のアプリへ読み込み権限を与える|
|MODE_WORLD_WRITEABLE| 他のアプリへ書き込み権限を与える|

> http://techbooster.org/tag/openfileoutput/

### 書き込みの例

```java
OutputStream out;
//OutputStream インスタンス作成
try {
  out = openFileOutput("log.txt", MODE_PRIVATE);
  // 出力ファイルをlog.txt, 権限をPRIVATE、このアプリでのみ利用可能とする
  PrintWriter writer = new PrintWriter(
    new OutputStreamWriter(out, "UTF-8"));
  // Outputstreamインスタンスとエンコーディングの設定
  EditText edit = (EditText)findViewById(R.id.edit_data);
  writer.append(edit.getText().toString());
  //editTextの内容をファイルに書き込む
  writer.close();
}catch...
```

### 読み込みの例

```java
    InputStream in;
    //InputStream インスタンス作成
    String lineBuffer;
    try {
      in = openFileInput("log.txt");
      BufferedReader reader = new BufferedReader(
        new InputStreamReader(in, "UTF-8"));
      while((lineBuffer = reader.readLine()) != null) {
        Log.v("TEST", lineBuffer);
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
```

  [ サンプルコード ]( https://gist.github.com/iberianpig/007b96e935dd607311ae/revisions )

## DBへの保存(書きかけ)


## Special Thanks

http://weide-dev.blogspot.jp/2010/09/sharedpreferences.html  

http://androlab.blogspot.jp/2011/01/blog-post_20.html  

http://techbooster.org/tag/openfileoutput/  
