class BooksController < ApplicationController
  before_action :require_user, except: [:show]

  def show
    # @book=Book.find(params[:id])
    @recommended_properties = Property.where(is_featured_product: true).limit(4)
    @book = current_user.books.find(params[:id])
  end
  
  def destroy
    @book = BookingItem.find(params[:id])
    @book.destroy
    flash[:notice] = "movie deleted!"
    respond_to do |format|
      format.js   
    end
  end
 
end
