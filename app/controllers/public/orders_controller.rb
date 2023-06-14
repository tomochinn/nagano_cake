class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
    # 注文(@orders)はcurrent_customerがカートに入れた商品(cart_items)
    @orders = current_customer.cart_items
    @order = Order.new(order_params)
    @total_price = 0
     # ご自身の住所(customer_address)を選択した場合

    if params[:order][:selected_address] == "customer_address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.recipient_name = current_customer.full_name

    # 登録済住所(registared_addresses)から選択した場合
    elsif params[:order][:selected_address] == "registared_address"
      @order.postal_code = Address.find(params[:order][:address_id]).postal_code
      @order.address = Address.find(params[:order][:address_id]).address
      @order.recipient_name = Address.find(params[:order][:address_id]).recipient_name

    # 新しいお届け先(new_address)から選択した場合
    elsif params[:order][:selected_address] == "new_address"

      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.recipient_name = params[:order][:recipient_name]

      # 新しいお届け先を保存する
      # current_customer.addresses.create(
      # postal_code: @order.postal_code,
      # address: @order.address,
      # recipient_name: @order.recipient_name
      # )

    end
  end

  def thanks
    # カートの中身を空にする
    # current_customer.cart_items.destroy_all
  end

  def create
    @order = Order.new(order_params)
    # current_customerの注文を確定する
    @order.customer_id = current_customer.id
    @order.save
    # byebug
    redirect_to orders_thanks_path
  end

  def index
    @orders = Order.all
    # current_customerの注文商品を確認する
    # @item.customer_id = current_customer.id
    @total_price = 0
  end

  def show
    @order = Order.find(params[:id])
    @total_price = 0
  end

  # ストロングパラメータ
  def order_params
    params.require(:order).permit(:selected_address, :recipient_name, :postal_code, :address, :shipping_fee,
                                  :billing_amount, :payment_method, :customer_id)
  end

end
