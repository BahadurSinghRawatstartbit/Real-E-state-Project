class WishlistsController < ApplicationController
  before_action :require_login
  before_action :set_property, only: [:create, :destroy]

  def index
    @wishlists = current_user.wishlists.includes(:property)
    @recommended_properties = Property.where(is_featured_product: true).limit(4) 
  end

  def create
    wishlist = current_user.wishlists.find_or_initialize_by(property: @property)

    if wishlist.persisted?
      render json: { status: "already_added" }, status: :ok
    elsif wishlist.save
      render json: { status: "added" }, status: :created
    else
      render json: { error: wishlist.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    wishlist = current_user.wishlists.find_by(property: @property)
    wishlist&.destroy
    respond_to do |format|
      format.js   
    end
    redirect_to your_property_index_path, notice: "Removed from wishlist"
    
  end

  private

  def set_property
    @property = Property.find(params[:property_id])
  end


  def require_login
    unless logged_in?
      flash[:alert] = "You have to login first"
      redirect_to login_path
    end
  end

end
