class BookingItemsController < ApplicationController
  before_action :require_user, except: [:destroy]



  def create
    @property = Property.find(params[:property_id])
    cart = current_cart
    raise "Cart missing" unless cart
    item = cart.add_property(@property.id)
    if item.save
      redirect_to book_path(cart), notice: "Property added to booking cart"
    else
      redirect_to properties_path, alert: item.errors.full_messages.join(", ")
    end
  end

  def destroy
    booking_item = BookingItem.find(params[:id])
    book = booking_item.book

    booking_item.destroy
    respond_to do |format|
      format.js   
    end
    redirect_to book_path(book), notice: "Property deleted!"
  end

  

end
