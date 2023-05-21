class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :recipient_name, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.integer :shipping_fee, null: false
      t.integer :billing_amount, null: false
      t.integer :payment_method, default: 0, null: false
      t.timestamps
    end
  end
end
