class Public::ItemsController < ApplicationController
  def index
    @items = Item.all.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    # @cart_item.save
    # redirect_to cart_items_path
  end
end
