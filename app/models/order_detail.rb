class OrderDetail < ApplicationRecord
  has_many :oders, dependent: :destroy
end
