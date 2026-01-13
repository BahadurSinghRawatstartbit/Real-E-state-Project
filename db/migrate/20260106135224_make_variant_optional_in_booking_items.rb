class MakeVariantOptionalInBookingItems < ActiveRecord::Migration[6.1]
  def change
    
    change_column_null :booking_items, :variant_id, true
    
  end
end
