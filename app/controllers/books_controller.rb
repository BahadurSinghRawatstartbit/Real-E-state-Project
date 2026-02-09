class BooksController < ApplicationController
  before_action :require_user, only: [:show]

  def show
    
    # @recommended_properties = Property.where(is_featured_product: true).limit(4)
    # @book = current_user.books.find(params[:id])

    @book = current_user.books.find(params[:id])
    # @property = @book.property

    @recommended_properties =
      Property.where(is_featured_product: true).limit(4)
  end
  
  def destroy
    @book = BookingItem.find(params[:id])
    @book.destroy
    flash[:notice] = "Property deleted!"
    respond_to do |format|
      format.js   
    end
  end
 
end
