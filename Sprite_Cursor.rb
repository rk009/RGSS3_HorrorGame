#==============================================================================
# ■ Sprite_Cursor
#------------------------------------------------------------------------------
# 　カーソルスプライト
#==============================================================================
class Sprite_Cursor < Sprite
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize(width, height, color1=Color.new(255,255,255,192), color2=Color.new(255,255,255,64))
    super(nil)
    self.z = 200
    self.x = 0
    self.y = 0
    @width = width
    @height = height
    @color1 = color1
    @color2 = color2
    @count = 0
    create_cursor
  end
  #--------------------------------------------------------------------------
  # ● カーソルを作成
  #--------------------------------------------------------------------------
  def create_cursor
    self.bitmap = Bitmap.new(@width, @height)
    bitmap.fill_rect(1, 1, @width-2, @height-2, @color2)
    bitmap.fill_rect(0, 0, @width, 1, @color1)
    bitmap.fill_rect(0, 1, 1, @height-2, @color1)
    bitmap.fill_rect(@width-1, 1, 1, @height-2, @color1)
    bitmap.fill_rect(0, @height-1, @width, 1, @color1)
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  def update
    super
    update_count
  end
  #--------------------------------------------------------------------------
  # ● 点滅の更新
  #--------------------------------------------------------------------------
  def update_count
    if @count < 160
      self.opacity = 255 - @count
      @count += 4
    else
      self.opacity = @count - 64
      @count += 4
    end
    @count = 0 if @count >= 320
  end
end