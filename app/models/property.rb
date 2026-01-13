class Property < ApplicationRecord
  has_many_attached :images
  validates :name, :status, :address, presence: true
  has_many :wishlisted_by_users, through: :wishlists, source: :user
  validates :images, presence: true
  has_many :wishlists, dependent: :destroy
  validate :images_presence
  has_many :booking_items, dependent: :destroy

 def active_features
    attributes
      .select { |_, value| value == true }
      .keys
      .map { |name| name.humanize }
  end
  private

  def images_presence
    errors.add(:images, "must be attached") unless images.attached?
  end
  
end

