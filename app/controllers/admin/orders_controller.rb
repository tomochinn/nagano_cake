class Admin::OrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
    # @orderの@order_detailを表示する
    @order_details = @order.order_details
    @total_price = 0
  end
  
  private
  # ストロングパラメータ
  def order_params
    params.require(:order).permit(:customer_id, :recipient_name, :postal_code, :address, :shipping_fee,
                                  :billing_amount, :payment_method, :selected_address)
  end
  
end
