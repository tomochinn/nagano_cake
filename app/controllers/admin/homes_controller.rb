class Admin::HomesController < ApplicationController
  
  def top
    @orders = Order.all
    # @order_detail = @orders.order_detail
  end
  
  private
  # ストロングパラメータ
  def top_params
    params.require(:top).permit(:image, :name, :introduction, :price, :id)
  end
  
end
