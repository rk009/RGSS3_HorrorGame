﻿#==============================================================================
# ■ RK::HorrorItems
#------------------------------------------------------------------------------
# 　アイテム画面用モジュール
#==============================================================================
module RK
  module HorrorItems
    
    # タイトル名
    TitleName = "ITEM"
    
    # タイトル画像(Graphics/System/)
    TitleImage = "title"

    # 使用アイコンセット
    IconSet = "WeaponSet"

    # アイテムのアイコンサイズ
    ItemWidth = 120
    ItemHeight = 120
    
    # 装備アイテムのボックスの色
    Color1 = Color.new(255, 128, 0, 200)
    Color2 = Color.new(255, 128, 0, 96)

  end
end

#==============================================================================
# ■ Sprite_Items_Cursor
#------------------------------------------------------------------------------
# 　アイテム画面装備用カーソルスプライト
#==============================================================================
class Sprite_ItemCursor < Sprite_Cursor
  #--------------------------------------------------------------------------
  # ● カーソルを作成
  #--------------------------------------------------------------------------
  def create_cursor
    self.bitmap = Bitmap.new(@width, @height)
    bitmap.fill_rect(2, 2, @width-3, @height-3, @color2)  # 中身
    bitmap.fill_rect(0, 0, @width, 2, @color1)            # 上部
    bitmap.fill_rect(0, 2, 2, @height-3, @color1)         # 左
    bitmap.fill_rect(@width-2, 2, 2, @height-3, @color1)  # 右
    bitmap.fill_rect(0, @height-2, @width, 2, @color1)    # 下部
  end
  #--------------------------------------------------------------------------
  # ● 点滅の更新
  #--------------------------------------------------------------------------
  def update_count
  end
end

#==============================================================================
# ■ Game_Actor
#------------------------------------------------------------------------------
# 　装備変更メソッド追加
#==============================================================================
class Game_Actor < Game_Battler
  #--------------------------------------------------------------------------
  # ● 装備の変更
  #--------------------------------------------------------------------------
  def rk_change_equip(slot_id, item)
    @equips[slot_id].object = item
  end
end

#==============================================================================
# ■ Window_Items
#------------------------------------------------------------------------------
# 　所持アイテムのを表示するウィンドウです。
#==============================================================================

class Window_Items < Window_RK
  #--------------------------------------------------------------------------
  # ● インクルード
  #--------------------------------------------------------------------------
  include RK::HorrorItems
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height)
    super(x, y, width, height)
    self.opacity = 0
    activate
  end
  #--------------------------------------------------------------------------
  # ● 項目の幅を取得
  #--------------------------------------------------------------------------
  def item_width
    ItemWidth
  end
  #--------------------------------------------------------------------------
  # ● 項目の高さを取得
  #--------------------------------------------------------------------------
  def item_height
    ItemHeight
  end
  #--------------------------------------------------------------------------
  # ● 横に項目が並ぶときの空白の幅を取得
  #--------------------------------------------------------------------------
  def spacing
    return 3
  end
  #--------------------------------------------------------------------------
  # ● 標準パディングサイズの取得
  #--------------------------------------------------------------------------
  def standard_padding
    return 25
  end
  #--------------------------------------------------------------------------
  # ● 桁数の取得
  #--------------------------------------------------------------------------
  def col_max
    return 4
  end
  #--------------------------------------------------------------------------
  # ● プレイヤーの装備アイテム取得
  #--------------------------------------------------------------------------
  def equip
    $game_player.actor.equips[0]
  end
  #--------------------------------------------------------------------------
  # ● 決定やキャンセルなどのハンドリング処理
  #--------------------------------------------------------------------------
  def process_handling
    super
    return call_key1_handler if handle?(:key1) && Input.trigger?(:Y)
  end
  #--------------------------------------------------------------------------
  # ● ハンドラの呼び出し
  #--------------------------------------------------------------------------
  def call_key1_handler
    Input.update
    deactivate
    call_handler(:key1)
  end
  #--------------------------------------------------------------------------
  # ● アイテムリストの作成
  #--------------------------------------------------------------------------
  def make_item_list
    @data = $game_party.all_items.select {|item| include?(item) }
    @data.push(nil) if include?(nil)
  end
  #--------------------------------------------------------------------------
  # ● アイテムをリストに含めるかどうか
  #--------------------------------------------------------------------------
  def include?(item)
    return item
  end
  #--------------------------------------------------------------------------
  # ● アイコンの描画
  #--------------------------------------------------------------------------
  def draw_icon(icon_index, x, y, enabled = true)
    bitmap = Cache.system( IconSet )
    icon_index -= 1
    icon_cols = bitmap.width / item_width
    rect = Rect.new(icon_index % icon_cols * item_width, icon_index / icon_cols * item_height, item_width, item_height)
    contents.blt(x, y, bitmap, rect, enabled ? 255 : translucent_alpha)
  end
  #--------------------------------------------------------------------------
  # ● 項目の描画
  #--------------------------------------------------------------------------
  def draw_item(i)
    item = @data[i]
    if item
      rect = item_rect(i)
      draw_icon(item.id, rect.x, rect.y)
      rect.x += 8
      contents.font.name = "HGP明朝E"
      contents.font.size = 14
      draw_text(rect.x, rect.y, rect.width, 30, item.name)
    end
  end
  #--------------------------------------------------------------------------
  # ● 装備項目の描画
  #--------------------------------------------------------------------------
  def draw_box(rect, item)
    @box.dispose if !equip && @box
    if equip && item && equip.id == item.id
      @box.dispose if @box
      @box = Sprite_ItemCursor.new(rect.width, rect.height, Color1, Color2)
      @box.x = rect.x + self.x + standard_padding
      @box.y = rect.y + self.y + standard_padding
    end
  end
  #--------------------------------------------------------------------------
  # ● 全項目の描画
  #--------------------------------------------------------------------------
  def draw_all_items
    8.times do |i|
      rect = item_rect(i)
      item = @data[i]
      contents.fill_rect(rect, Color.new(0, 0, 0, 128))
      draw_item(i)
      draw_box(rect, item)
    end
  end
  #--------------------------------------------------------------------------
  # ● ヘルプテキスト更新
  #--------------------------------------------------------------------------
  def update_help
    @help_window.set_item(item)
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  def update
    super
    @box.update if @box && equip
  end
  #--------------------------------------------------------------------------
  # ● 解放
  #--------------------------------------------------------------------------
  def dispose
    @box.dispose if @box
    super
  end
end

#==============================================================================
# ■ Scene_Items
#------------------------------------------------------------------------------
# 　アイテム画面の処理を行うクラスです。
#==============================================================================

class Scene_Items < Scene_ItemBase
  #--------------------------------------------------------------------------
  # ● 開始処理
  #--------------------------------------------------------------------------
  def start
    super
    create_background
    create_title_window
    create_help_window
    create_items_window
  end
  #--------------------------------------------------------------------------
  # ● 背景の作成
  #--------------------------------------------------------------------------
  def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = Cache.system( RK::HorrorItems::TitleImage )
  end
  #--------------------------------------------------------------------------
  # ● 背景の解放
  #--------------------------------------------------------------------------
  def dispose_background
    @background_sprite.dispose
  end
  #--------------------------------------------------------------------------
  # ● タイトルウィンドウの作成
  #--------------------------------------------------------------------------
  def create_title_window
    @title_window = Window_Title.new
    @title_window.set_text( RK::HorrorItems::TitleName )
  end
  #--------------------------------------------------------------------------
  # ● ヘルプウィンドウの作成
  #--------------------------------------------------------------------------
  def create_help_window
    @help_window = Window_Description.new(@title_window.height)
    @help_window.viewport = @viewport
  end
  #--------------------------------------------------------------------------
  # ● アイテムリストの作成
  #-------------------------------------------------------------------------
  def create_items_window
    wy = @title_window.height + @help_window.height
    wh = Graphics.height - wy
    @item_window = Window_Items.new(0, wy+16, Graphics.width, wh)
    @item_window.viewport = @viewport
    @item_window.help_window = @help_window
    @item_window.set_handler(:ok, method(:on_item_ok))
    @item_window.set_handler(:cancel, method(:return_scene))
    @item_window.set_handler(:key1, method(:on_item_off))
  end
  #--------------------------------------------------------------------------
  # ● アイテムを装備する［決定］
  #--------------------------------------------------------------------------
  def on_item_ok
    Sound.play_equip
    $game_player.actor.rk_change_equip(0, @item_window.item)
    @item_window.refresh
    @item_window.activate
  end
  #--------------------------------------------------------------------------
  # ● アイテムを外す[S]
  #--------------------------------------------------------------------------
  def on_item_off
    Sound.play_equip
    $game_player.actor.rk_change_equip(0, nil)
    @item_window.refresh
    @item_window.activate
  end
end

