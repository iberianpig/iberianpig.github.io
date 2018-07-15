---
layout: post
title: 緯度経度と距離
published: false
date: 2016-01-07
comments: true
tags: 
categories: ruby
image: https://upload.wikimedia.org/wikipedia/commons/d/dd/West_Africa_Catalan_Atlas.jpg
---

円周率     = p
地球の半径 = r
地球の円周 = 2pr
経度 = lat
経度latの時の半径(緯度が大きいほど小さくなる)  w = r * cos(lat)
経度latの時の円周 = 2pw = 2pr * cos(lat)
緯度lat上の経度1度差分の距離dis = 2pw/360 = 2pr * cos(lat) / 360 = pr/180 * cos(lat)

dis =  pr/180 * cos(latA)
100 =  pr/180 * cos((35+X)*PI/180)
