class Address < ApplicationRecord
  
  belongs_to :customer
  
  def address_display
  '〒' + postal_code + ' ' + address + ' ' + recipient_name
  end

end
