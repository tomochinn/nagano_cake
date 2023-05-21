class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :amount, null: false
      t.integer :purchase_price, null: false
      t.timestamps
    end
  end
end
