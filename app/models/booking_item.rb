class BookingItem < ApplicationRecord
  belongs_to :book
  belongs_to :property
  belongs_to :variant, optional: true

  validates :quantity, numericality: { greater_than: 0 }
end

