class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!

  def index
    # current_customerに関連付けられたcart_itemsを取得し、@cart_itemsに渡す
    @cart_items = current_customer.cart_items
    @total_price = 0
  end

  def create
    @cart_items = current_customer.cart_items
    # 1. 追加した商品がカート内に存在するかの判別
    cart_item = @cart_items.find_by(item_id: params[:cart_item] [:item_id])

    if cart_item.present?
      # 2. カート内の個数をフォームから送られた個数分追加する
      cart_item.amount += params[:cart_item] [:amount].to_i
      cart_item.save
    else
      # 存在しなかった場合、カートモデルに新規レコードを作成する
      cart_item = @cart_items.new(cart_item_params)
      cart_item.save
    end
  
    redirect_to cart_items_path, notice: 'Successfully added item to your cart'
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path, notice: 'Successfully updated your cart'
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path, notice: 'Successfully deleted one your cart'
  end

  def destroy_all
    cart_items = current_customer.cart_items
    cart_items.destroy_all
    # current_customer.cart_items.destroy_all
    redirect_to cart_items_path, notice: 'Successfully deleted all cart item'
  end
  
  

  private

  # ストロングパラメータ
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end

end
