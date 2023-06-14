class Admin::OrderDetailsController < ApplicationController
  
  def show
    @order_details = OrderDetail.all
  end
  
  private
  # ストロングパラメータ
  def order_detail_params
    params.require(:order_detail).permit()
  end
  
end
