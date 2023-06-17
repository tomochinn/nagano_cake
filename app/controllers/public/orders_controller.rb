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
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    # current_customerの注文を確定する
    @order.save
    
    current_customer.cart_items.each do |cart_item| 
      # order_detailモデルの新しいインスタンス作成
      order_detail = OrderDetail.new
      
      # order_detailのorder_idに、@order.idを設定
      order_detail.order_id = @order.id
      # order_detailのitem_idに、cart_item内の商品のID（item_id）を設定
      order_detail.item_id = cart_item.item_id
      # order_detailのamountに、cart_item内のアイテムのamountを設定
      order_detail.amount = cart_item.amount
      # order_detailのpurchase_priceに、cart_item内のitem.with_tax_price（itemモデルに税込みの計算を定義している）を設定
      order_detail.purchase_price = cart_item.item.with_tax_price
      # order_detailをデータベースに保存
      order_detail.save
      # 注文完了したらカート内を空にする
      cart_item.destroy
    end
    
    # サンクスページに遷移する
    redirect_to orders_thanks_path
    
  end

  def index
    @orders = current_customer.orders
    @total_price = 0
  end

  def show
    @order = Order.find(params[:id])
    # @order_detailsで@orderの中のorder_detailsを取得
    @order_details = @order.order_details
    # current_customerの@order_detailsを表示する
    # @order_detail = current_customer.@order_details
    @total_price = 0
  end

  # ストロングパラメータ
  def order_params
    params.require(:order).permit(:selected_address, :recipient_name, :postal_code, :address, :shipping_fee,
                                  :billing_amount, :payment_method, :customer_id)
  end

end
