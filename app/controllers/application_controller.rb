class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in? ,:current_cart
  def current_user
    # @current_user ||= User.find(session[:user_id]) if session[:user_id]
    return unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def logged_in?
    !!current_user
  end
  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end

 def current_cart
  return unless current_user

  @current_cart ||= current_user.books.find_or_create_by!(
    status: "cart"
  ) do |book|
    book.total_amount = 0
  end
 end



end
