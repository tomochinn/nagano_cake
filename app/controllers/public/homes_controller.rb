class Public::HomesController < ApplicationController
  def top
    @items = Item.all
    @item = Item.new
    # 新着商品を上から3件取得
    # @items_latest4 = @item.first(4)
    # 新着商品3件を除く全商品を取得 (4件以下の場合は空)
    # @items_offset4 = @item.offset(4)
  end

  def about
  end
  
  private

  # ストロングパラメータ
  def home_params
    params.require(:home).permit(:item_id, :name, :introduction, :price)
  end
  
end
