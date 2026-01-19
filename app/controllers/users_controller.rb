class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :redirect_if_logged_in, only: [:new, :create]


  def new
    
    @user = User.new
  end

  def show
    
  end

  def index
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # Tell the UserMailer to send a welcome email after save
        UserMailer.with(user: @user).welcome_email.deliver_later

        format.html { redirect_to user_url(@user), notice: "Welcome  #{@user.name}, you have successfully signed up" }
        format.json { render :show, status: :created, location: @user }
        redirect_to root_path
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        render 'new'
      end
    end
  end
  # def create
  #   @user = User.new(user_params)
    
  #   if @user.save
  #     session[:user_id] = @user.id
  #     flash[:notice] = "Welcome  #{@user.name}, you have successfully signed up"
  #     redirect_to root_path
  #   else
  #     render 'new'
  #   end
  # end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email,:mobilenumber, :password,:password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end


  def redirect_if_logged_in
    if logged_in?
      redirect_to root_path, notice: "You are already logged in!"
    end
  end
 

 
end
