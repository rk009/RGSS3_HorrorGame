# RGSS3_HorrorGame
####Window_RK
#####継承元クラス：Window_Base
- 自分用カーソルを適用させたベースウィンドウクラス
- 公開しているWindowの大半で使用している

####Sprite_Cursor
- color1：カーソルの外枠, color2：カーソルの内側
- 自分用カーソルクラス  

####Window_Title
#####継承元クラス：Window_Line
setしたテキストを表示する  

####Window_Description
#####継承元クラス：Window_Line
yの位置にsetしたテキストを表示する  

---

####Scene_Items
#####使用ウィンドウ：Window_Items, Window_Title, Window_Description

```ruby:qiita.rb
SceneManager.call( Scene_Items )
```
#####仕様
- Enterキーで装備する
- Sキーで装備品を外す
- 8アイテムのみ描写可能なアイテムウィンドウになる
- アイテムのアイコンセットやタイトルを自由に決めることができる

---

####Scene_Menu
#####使用ウィンドウ：Window_Title, Window_MenuList, Window_MenuMain
#####仕様
- モジュールで簡単にコマンドを追加できる
- Mainはまだ決定していない（装備品を描画の予定）
