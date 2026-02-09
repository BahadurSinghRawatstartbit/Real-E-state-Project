class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create,:admin_login ,:admin_create ,:agent_login ,:agent_create]

  

  def admin_login; end
  def agent_login; end
  



  def admin_create
    user = User.find_by(email: params[:session][:email].downcase)

    if user&.authenticate(params[:session][:password]) && user.has_role?(:admin)
      session[:user_id] = user.id
      redirect_to admin_dashboard_path, notice: "Admin logged in"
    else
      flash.now[:alert] = "Invalid admin credentials"
      render :admin_login
    end
  end

  def agent_create
  
    user = User.find_by(email: params[:session][:email].downcase)

    if user&.authenticate(params[:session][:password]) && user.has_role?(:agent)
      session[:user_id] = user.id
      redirect_to agent_dashboard_path, notice: "Agent logged in"
    else
      flash.now[:alert] = "Invalid agent credentials"
      render :agent_login
    end
  end
  def block_login_routes
    if logged_in? && request.path.in?([login_path, login_admin_path, login_agent_path])
      redirect_if_logged_in
    end
  end

  # Normal user login
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    

    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id

      # role-based redirect
      if user.has_role?(:admin)
        redirect_to admin_dashboard_path
      elsif user.has_role?(:agent)
        redirect_to agent_dashboard_path
      else
        redirect_to root_path
      end
    else
      flash.now[:alert] = "Invalid email or password"
      render 'new'
    end
  end

  # def create
  #   user = User.find_by(email: params[:session][:email].downcase)
  #   if user && user.authenticate(params[:session][:password])
  #     session[:user_id] = user.id
  #     flash[:notice] = "Logged in successfully"
  #     redirect_to root_path
  #   else
  #      flash[:danger] = "Invalid email or password"
     
  #     render 'new'
  #   end
  # end

  # def redirect_if_logged_in
  #   if logged_in?
  #     redirect_to root_path, notice: "You are already logged in!"
  #   end
  # end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end
  
end