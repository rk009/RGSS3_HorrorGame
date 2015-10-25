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
####継承元クラス：
Window_RK  
####使用ウィンドウ：
Window_Items, Window_Title, Window_Description

```ruby:qiita.rb
SceneManager.call( Scene_Items )
```
####仕様
- Enterキーで装備する
- Sキーで装備品を外す
- 8アイテムのみ描写可能なアイテムウィンドウになる
- アイテムのアイコンセットやタイトルを自由に決めることができる

###Scene_Menu
####継承元クラス：
Window_RK
####使用ウィンドウ：
Window_Title, Window_MenuList, Window_MenuMain

####仕様
- モジュールで簡単にコマンドを追加できる
- Mainはまだ決定していない（装備品を描画の予定）
