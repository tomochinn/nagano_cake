class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!
  before_action :set_cart_item, only: %i[update destroy destroy_all]

  def index
    # current_customerに関連付けられた.cart_itemsを取得し、@cart_itemsに渡す
    @cart_items = current_customer.cart_items
  end

  def create
    # current_customerが購入したい商品をカートに入れる
    @cart_items = current_customer.cart_items
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path, notice: 'Successfully added item to your cart'
  end
  
  def update
    @cart_item.update(:quantity, 1)
    redirect_to request.referer, notice: 'Successfully updated your cart'
  end

  def destroy
    destroy(@cart_item)
    redirect_to request.referer, notice: 'Successfully deleted one your cart'
  end

  def destroy_all
    @cart_item.destroy_all
    redirect_to request.referer, notice: 'Successfully deleted all cart item'
  end
  
  

  private

  def current_cart
    if session[:cart_id]
      current_cart = Cart.find_by(id: session[:cart_id])
      current_cart = Cart.create unless current_cart
      session[:cart_id] = current_cart.id
      current_cart
    end
  end

  # ストロングパラメータ
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end

end
