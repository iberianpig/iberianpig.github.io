---
layout: post
title: "twitterbootstrapでnavbarがモバイル表示にならない"
published: true
date: 2014-09-12
comments: true
tags: 
  - bootstrap
categories: css
---

mobileデバイス用のViewが768pxの際に切り替えが行われない。
PCブラウザ上では、サイズ変更時にViewが変わったが、実機やDeveloper toolでのエミュレーションでは適用されなかった。

```html
<meta name="viewport" content="width=device-width, initial-scale=1">
```

つまるところ、これをhtmlのヘッダに下記を書き込んで置かないと行けなかった。
小一時間使ってしまった。



ご参考(http://getbootstrap.com/css/#overview-mobile)

> # Mobile first
> With Bootstrap 2, we added optional mobile friendly styles for key aspects of the framework. With Bootstrap 3, we've rewritten the project to be mobile friendly from the start. Instead of adding on optional mobile styles, they're baked right into the core. In fact, Bootstrap is mobile first. Mobile first styles can be found throughout the entire library instead of in separate files.
> 
> To ensure proper rendering and touch zooming, add the viewport meta tag to your <head>.
> 
> ```
> <meta name="viewport" content="width=device-width, initial-scale=1">
> ```
> You can disable zooming capabilities on mobile devices by adding user-scalable=no to the viewport meta tag. This disables zooming, meaning users are only able to scroll, and results in your site feeling a bit more like a native application. Overall, we don't recommend this on every site, so use caution!
> ```
> <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
> ```
