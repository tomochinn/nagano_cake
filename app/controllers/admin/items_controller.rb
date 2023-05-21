class Admin::ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @items = Item.all
    @item = Item.new(item_params)
    # saveメソッド
    @item.save
    redirect_to admin_item_path(@item.id)
  end

  def show
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    # saveメソッド
    @item.save
    redirect_to admin_item_path(@item.id)
  end

private
  # ストロングパラメータ
  def item_params
    params.require(:item).permit(:name, :introduction, :price)
  end
  
end