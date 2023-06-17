class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    #先ほど新規登録したitemの詳細ページにリダイレクト
    redirect_to admin_item_path(@item.id)
  end

  def show
    @item = Item.find(params[:id])
    # submit'カートに入れる'を実行するために.newのアクションが必要
    @cart_item = CartItem.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    #先ほど編集したitemの詳細ページにリダイレクト
    redirect_to admin_item_path(@item.id)
  end

private
  # ストロングパラメータ
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :id)
  end

end