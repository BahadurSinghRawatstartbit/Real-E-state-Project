class Wishlist < ApplicationRecord
  belongs_to :property
  belongs_to :user
  validates :property_id, uniqueness: { scope: :user_id }

end

