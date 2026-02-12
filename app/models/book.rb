class Book < ApplicationRecord
  belongs_to :user
  has_many :booking_items, dependent: :destroy

  validates :status, presence: true
  validates :total_amount, numericality: { greater_than: -1 },if: :confirmed?
  
  def confirmed?
    status != "cart"
  end
  

   def add_property(property_id)
  raise "Book not saved" unless persisted?

  current_item = booking_items.find_by(property_id: property_id)

  if current_item
    current_item.quantity = 1
  else
    current_item = booking_items.build(
      property_id: property_id,
      quantity: 1
    )
  end

  current_item
   end


  
  

end
