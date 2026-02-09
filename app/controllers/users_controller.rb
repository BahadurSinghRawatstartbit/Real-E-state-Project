class UsersController < ApplicationController
  before_action :set_user, only: [ :show,:edit, :update]
  before_action :redirect_if_logged_in, only: [:new, :create, :agent_new, :agent_create, :admin_new, :admin_create]
  before_action :require_super_admin, only: [:admin_new, :admin_create,:index]
# before_action :block_login_routes

  def new
    @user = User.new
  end

  def show
    
  end

  def index
    @users=User.all
  end

  def create
    
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        UserMailer.with(user: @user).welcome_email(@user).deliver_now
        format.html { redirect_to root_path, notice: "Welcome  #{@user.name}, you have successfully signed up" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def block_login_routes
    if logged_in? && request.path.in?([login_path, login_admin_path, login_agent_path])
      redirect_if_logged_in
    end
  end

  def agent_new
    @user = User.new
  end

  def agent_create
    
    @user = User.new(user_params)
    if @user.save
      @user.assign_role(:agent)
      session[:user_id] = @user.id
      redirect_to agent_dashboard_path
    else
      render :agent_new
    end
  end

  
  def admin_new
    require_super_admin
    @user = User.new
  end

  def admin_create
    require_super_admin
    @user = User.new(user_params)
    if @user.save
      @user.assign_role(:admin)
      redirect_to admin_dashboard_path
    else
      render :admin_new
    end
  end


  def edit
    
  end

  def update

    

    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User  deleted!"
    respond_to do |format|
      format.js   
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email,:mobilenumber, :password,:password_confirmation)
  end

  def set_user
    if current_user&.has_role?(:admin) && params[:id]
      @user = User.find(params[:id])  
    else
      @user = current_user            
    end
  end
  


  # def redirect_if_logged_in
  #   byebug
  #   if logged_in?
  #     redirect_to root_path, notice: "You are already logged in!"
  #   end
  # end
  def require_super_admin
    unless current_user&.has_role?(:admin)
      redirect_to admin_dashboard_path, alert: "Not authorized"
    end
  end
  
 

 
end
