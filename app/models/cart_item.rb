class CartItem < ApplicationRecord
  
  belongs_to :customer
  belongs_to :item

  #    カートアイテムの追加
  def add_item(product_id:, quantity:)
    # カートに入っていない商品を追加する場合はItemレコードを新規作成
    item = items.find_by(product_id: product_id) || items.build(product_id: product_id)
    item.quantity += quantity.to_i
    item.save
  end

  #    カートアイテムの更新
  def update_item(product_id:, quantity:)
    items.find_by(product_id: product_id).update(quantity: quantity.to_i)
  end

  #    カートアイテムの削除
  def delete_item(product_id:)
    items.find_by(product_id: product_id).destroy
  end

  #    カートの合計の算出
  def total_price
    items.sum("quantity*price")
  end
  
  ## 小計を求めるメソッド
  def subtotal
      item.with_tax_price * amount
  end

end
