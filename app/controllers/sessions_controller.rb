class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully"
      redirect_to root_path
    else
       flash[:danger] = "Invalid email or password"
     
      render 'new'
    end
  end

  def redirect_if_logged_in
    if logged_in?
      redirect_to root_path, notice: "You are already logged in!"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end
end