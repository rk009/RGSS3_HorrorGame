# RGSS3_HorrorGame
###Window_RK
(x, y, width, height)  
自分用カーソルを適用させたベースウィンドウクラス  

###Sprite_Cursor
(width, height, color1, color2)  
color1：カーソルの外枠  
color2：カーソルの内側  
自分用カーソルクラス  

###Window_Title
setしたテキストを表示する  

###Window_Description
yの位置にsetしたテキストを表示する  

###Scene_Items
継承元クラス：Window_RK
使用ウィンドウ：Window_Items, Window_Title, Window_Description

```ruby:qiita.rb
SceneManager.call( Scene_Items )
```

8アイテムのみ描写可能なアイテムウィンドウになる  
アイテムのアイコンセットやタイトルを自由に決めることができる  

