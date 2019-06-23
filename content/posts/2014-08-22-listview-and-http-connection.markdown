---
layout: post
title: "ListView and http connection"
published: true
date: 2014-08-01
comments: true
tags:
  - android
  - HTTP
  - ListView
  - Thread

---

# 雑多メモ

Railsで作ったサーバとHttpでCRUDなおしゃべりをするアプリを作った時に調べたメモ達


## レイアウトをJava側で生成する
        LinearLayout linearLayout = new LinearLayout(this);
        linearLayout.setOrientation(LinearLayout.VERTICAL);
        setContentView(linearLayout);`

## レイアウトに要素を追加する
       Button button1 = new Button(this);
        button1.setText("OK");
        button1.setLayoutParams(new LinearLayout.LayoutParams(
            LinerLayout.LayoutParams.MATCH_PARENT,
            LinerLayout.LayoutParams.WRAP_CONTENT));
        linearLayout.addView(button1);`

<!-- more -->

### AddViewメソッド
「LinearLayout」クラスの親クラスである「ViewGroup」クラスで用意されている「addView」メソッドを使います。

> public void addView(View child, LayoutParams params)
> Adds a child view with the specified layout parameters.

 Parameters:
  child:  the child view to add
  params:  the layout parameters to set on the child

> LinearLayout.LayoutParamsクラス

> 「android.widget.LinearLayout.LayoutParams」クラスは「android.view.ViewGroup.LayoutParams」クラスのサブクラスです。コンストラクタの1つのは次のようになっています。

    LayoutParams
    public LinearLayout.LayoutParams(int w, int h)
    
## 他のビューに対する相対位置の指定(addRule)

> このビュー自身のサイズに関する設定の他に、別に追加されたビューに対する位置関係を設定することが出来ます。「RelativeLayout.LayoutParams」クラスで用意されている「addRule」メソッドを使います。
(参考:　http://www.javadrive.jp/android/relativelayout/index3.html) 

addRule
public void addRule(int verb, int anchor)
Adds a layout rule to be interpreted by the RelativeLayout. Use this for 
verbs that take a target, such as a sibling (ALIGN_RIGHT) or a boolean 
value (VISIBLE).

Parameters:
  verb  One of the verbs defined by RelativeLayout, such as 
    ALIGN_WITH_PARENT_LEFT.
  anchor  The id of another view to use as an anchor, or a boolean 
    value(represented as TRUE) for true or 0 for false). For verbs that 
    don't refer to another sibling (for example, ALIGN_WITH_PARENT_BOTTOM) 
    just use -1.


### Windowのタイトルを消す
* onCreate内に下記を記述
    * `requestWindowFeature(Window.FEATURE_NO_TITLE);`


## ListViewの扱い方
* `List<String> items = new ArrayList<String>();`
* ListViewに値を追加する場合はArrayAdapterを用いる
* 独自クラスのリストを扱う場合は下記が必要
    * 独自クラスの作成(id, name, url, 画像等)
    * XMLレイアウトを作成(独自クラスが収まるようなレイアウト)
*  ListViewに追加するArrayAdapter<class>(context, layout)
   `ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1);`

* アイテムの追加
 
```java
adapter.add("red");
adapter.add("green");
adapter.add("blue");
ListView listView = (ListView) findViewById(id.listview);
```
* リストビューのアイテムがクリックされた時に呼び出されるコールバックリスナーを登録
    * listview.getItemAtPosition(position)でリスト上のオブジェクトを取得
 
 ``java
 listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
     @Override
     public void onItemClick(AdapterView<?> parent, View view,
             int position, long id) {
         ListView listView = (ListView) parent;
         String item = (String) listView.getItemAtPosition(position);
         Toast.makeText(ListViewSampleActivity.this, item, Toast.LENGTH_LONG).show();
     }
 });
 ```

## Threadの扱い
* 基本的にMainでUIを担当する
* サブThread上でUI描画を実行するとエラーとなってしまうので要注意
* Handlerクラスを宣言し、描画Thred内でhandler.postすることでMainに描画部分を引き渡せる(http://www.adamrocker.com/blog/255/hello-android-chapter7-the-connected-world.html)
* ↑の処理をラップしているrunOnUiThreadメソッドが便利そう。(http://visible-true.blogspot.jp/2011/11/activityrunonuithreadrunnable.html)


## Http通信を行う場合
* インターネット接続を許可する為に、AndroidManifest.xmlに以下を
* 記述する。
`<uses-permission android:name="android.permission.INTERNET"></uses-permissio>`
* メインスレッドで通信を行った場合、Android4では"android.os.StrictMode$AndroidBlockGuardPolicy.onNetwork"エラーが発生し動作しない。
    * Android4ではメインスレッドからネットワークにアクセスする処理を実行することができなくなったため。
    * HTTPでdataを取得する場合はサブスレッドで取得する必要がある

## 非同期タスク(AsyncTask)
AsyncTask(Android独自のクラス)をextendsして、サブスレッドとメインスレッドを分けて動作させる。View操作とロジック計算を分離させる

* doInBackgroundメソッド
    * subスレッドとして動作
    * 非同期のHttpリクエストを実装とか
* onPostExecuteメソッド
    * doInBackground終了時に呼ばれる
    * mainスレッドとして実行する。
    * UI更新内容を実装したりとか。
* 参考URL
    * (http://www.ipentec.com/document/document.aspx?page=android-get-html-file-use-http-for-android4)
    * (http://www.office-matsunaga.biz/android/description.php?id=9)

## レイアウトの取得・差し替え(inflater)

> Androidのプログラミングでは、画面のViewを構成する場合、layout用xmlファイルを用いて、レイアウトを作成することが推奨されている。
> しかし、xmlファイルを用いた場合、それは、静的にレイアウトが決定付けられてしまい、プログラムの実行時にレイアウトを変形することはできない。
> この不都合を回避するため、LayoutInflater Classが用意されており、このクラスを活用することにより、実行時にお好みのレイアウトに変形できる。
(https://sites.google.com/site/androyerjapan/home/layoutinflater)

* inflaterによりxmlレイアウトの差し替えを行うことができる
* inflaterの取得方法は3種類ある
    * コンテキストから取得
    `LayoutInflater inflater1 = LayoutInflater.from(this);`
    * アクティビティから取得
    `LayoutInflater inflater2 = getLayoutInflater();`
    * システムサービスから取得
    ` LayoutInflater inflater3 = (LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE);`

  上3つとも動きは一緒らしい

* 差し替えの方法(レイアウトXMLから取得したビューを画面に反映させる)

1. レイアウトインフレーターを取得
  `LayoutInflater inflater1 = LayoutInflater.from(this);`
 
2. レイアウトXMLからビューを取得
`View view = inflater.inflate(R.layout.main, null);`
 
3. ビューを画面に反映
`setContentView(view);`

> 最後のビューを画面に反映する処理は、リソースIDを指定する setContentView(R.layout.main) と同じ結果になります。

(参考サイト： http://inujirushi123.blog.fc2.com/blog-entry-27.html) 



* convertView
```java
// convertViewは使い回しされている可能性があるのでnullの時だけ新しく作る
if (null == convertView) {
    convertView = layoutInflater_.inflate(R.layout.hoge_layout, null);
}
```

下記の説明を読んで少しハラオチした。
http://hyoromo.hatenablog.com/entry/20090912/1252777077

convertView自体はListViewをScrollした時のList一行生成時に呼ばれるgetViewに必要。
getView自体はAdapterクラスだと持ってるコールバック。

一度でもgetViewを行ってさえいれば、AdapterクラスのインスタンスはconvertViewのプロパティ
を保持しており、それを毎回getViewに代入する。

そのため、もし持っていなかったらLayoutInflaterで新しくconvertView取ってくるよという動きをする




## その他/不明点
見てたサイト達
http://www.one-tab.com/page/0QqPosDYSompC8jtQAdzMA
