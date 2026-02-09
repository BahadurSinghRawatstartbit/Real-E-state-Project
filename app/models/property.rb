class Property < ApplicationRecord
    
  has_many_attached :images
  validates :name, :status, :address, presence: true
  has_many :wishlisted_by_users, through: :wishlists, source: :user
  validates :images, presence: true
  has_many :wishlists, dependent: :destroy
  validate :images_presence
  has_many :booking_items, dependent: :destroy
  
  def self.ransackable_associations(auth_object = nil)
    %w[wishlists booking_items]
  end

  
  def self.ransackable_attributes(auth_object = nil)
    %w[
      name description city state status price completiondate
      fireplace swimmingpool twostories laundryroom jogpath
      ceilings dualsinks is_featured_product area bedroom bathroom emergencyexit
    ]
  end



  def active_features
    attributes
      .select { |key, value| value == true && self.class.ransackable_attributes.include?(key) }
      .keys
      .map(&:humanize)
  end
  private

  def images_presence
    errors.add(:images, "must be attached") unless images.attached?
  end
  
end
