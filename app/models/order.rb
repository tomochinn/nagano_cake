class Order < ApplicationRecord
  enum payment_method: { credit: 0, bank: 1 
end
