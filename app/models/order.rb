class Order < ApplicationRecord
  belongs_to :order_detail
  enum payment_method: { credit_card: 0, transfer: 1 }
end
