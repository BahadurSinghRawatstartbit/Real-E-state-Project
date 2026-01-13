class PagesController < ApplicationController
    before_action :require_user, except: [:home]

  def home
    @featured_properties = Property.with_attached_images.where(is_featured_product: true).order(created_at: :desc).limit(8)
    # byebug
  end
  def contact
    
  end
end
