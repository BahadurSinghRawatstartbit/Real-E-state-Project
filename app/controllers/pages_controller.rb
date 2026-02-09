class PagesController < ApplicationController
    before_action :require_user, except: [:home,:contact_submit,:subscribe]
    before_action :require_admin, only: [:chat_query_list]

  def home
    @featured_properties = Property.with_attached_images.where(is_featured_product: true).order(created_at: :desc).limit(8)
    
  end
  def contact_submit
    name = params[:firstname] + " " + params[:lastname]
    email = params[:email]
    subject = params[:subject]
    message = params[:message]
    
    if name.present? && email.present? && message.present?
      # UserMailer.contact_form_submission(name, email, subject, message).deliver_now
      flash[:notice] = "Thank you #{name}! Your message has been sent successfully."
    else
      flash[:alert] = "Please fill in all required fields"
    end
    
    redirect_to pages_contact_path
    
  end
  # def subscribe
  #   # Handle newsletter subscription
  #   email = params[:email]
    
  #   if email.present? && email.match?(URI::MailTo::EMAIL_REGEXP)
  #     # Send subscription confirmation email
  #     # UserMailer.subscription_confirmation(email).deliver_now
  #     flash[:notice] = "Thank you for subscribing! Check your email for confirmation."
  #   else
  #     flash[:alert] = "Please enter a valid email address"
  #   end
    
  #   redirect_back(fallback_location: root_path)
  # end

  def chat_query_list
    
  end

  def msgpage
    @conversation = Conversation.where(
      "user_id = :id OR admin_id = :id",
      id: current_user.id
    ).first

    # create conversation if it doesn't exist
    if @conversation.nil?
      admin = User.joins(:roles).find_by(roles: { name: "admin" })
      @conversation = Conversation.create!(
        user: current_user,
        admin: admin
      )
    end

    @messages = @conversation.messages
  end
  
end
