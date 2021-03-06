﻿#==============================================================================
# ■ Window_Line
#------------------------------------------------------------------------------
# 　画面上部にラインを表示する
#==============================================================================
class Window_Line < Window_Base
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize(y)
    super(0, y, item_width, item_height)
    self.opacity = 0
    @text = ""
  end
  #--------------------------------------------------------------------------
  # ● ウィンドウ内容の幅を計算
  #--------------------------------------------------------------------------
  def item_width
    return Graphics.width
  end
  #--------------------------------------------------------------------------
  # ● ウィンドウ内容の高さを計算
  #--------------------------------------------------------------------------
  def item_height
    return 40
  end
  #--------------------------------------------------------------------------
  # ● 標準パディングサイズの取得
  #--------------------------------------------------------------------------
  def standard_padding
    return 0
  end
  #--------------------------------------------------------------------------
  # ● セット
  #--------------------------------------------------------------------------
  def set_text(text)
    if text != @text
      @text = text
      refresh
    end
  end
  #--------------------------------------------------------------------------
  # ● アイテム設定
  #     item : スキル、アイテム等
  #--------------------------------------------------------------------------
  def set_item(item)
    set_text(item ? item.description : "")
  end
  #--------------------------------------------------------------------------
  # ● テキスト描画
  #--------------------------------------------------------------------------
  def create_text
    rect = contents.rect
    rect.x += 20
    draw_text(rect, @text)
  end
  #--------------------------------------------------------------------------
  # ● クリア
  #--------------------------------------------------------------------------
  def clear
    set_text("")
  end
  #--------------------------------------------------------------------------
  # ● フォント設定
  #--------------------------------------------------------------------------
  def font_settings
    contents.font.name = font_name
    contents.font.size = font_size
    contents.font.outline = font_outline?
    contents.font.bold = font_bold?
    change_color(text_color(font_color))
  end
  #--------------------------------------------------------------------------
  # ● フォント名
  #--------------------------------------------------------------------------
  def font_name
    return "HGP明朝E"
  end
  #--------------------------------------------------------------------------
  # ● フォントサイズ
  #--------------------------------------------------------------------------
  def font_size
    return 14
  end
  #--------------------------------------------------------------------------
  # ● 文字カラー
  #--------------------------------------------------------------------------
  def font_color
    return 0
  end
  #--------------------------------------------------------------------------
  # ● 文字アウトライン
  #--------------------------------------------------------------------------
  def font_outline?
    return false
  end
  #--------------------------------------------------------------------------
  # ● 文字太字
  #--------------------------------------------------------------------------
  def font_bold?
    return false
  end
  #--------------------------------------------------------------------------
  # ● 背景作成
  #--------------------------------------------------------------------------
  def create_background
  end
  #--------------------------------------------------------------------------
  # ● リフレッシュ
  #--------------------------------------------------------------------------
  def refresh
    contents.clear
    font_settings
    create_background
    create_text
  end
end

