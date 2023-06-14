class Address < ApplicationRecord
  
  def address_display
  '〒' + postal_code + ' ' + address + ' ' + recipient_name
  end

end
