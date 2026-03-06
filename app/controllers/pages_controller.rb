class PagesController < ApplicationController
    before_action :require_user, except: [:home,:contact,:subscribe]
    before_action :require_admin, only: [:chat_query_list]

  def home
    sanitize_q_params
    @q = Property.ransack(params[:q])
    

    @properties = @q.result(distinct: true)
    @banner = Managesection.find_by(section_type: 'home_banner')
    @testimonials = Managesection.find_by(section_type: 'testimonials')
    @welcome= Managesection.find_by(section_type: 'wellcome_banner')
    @cta = Managesection.find_by(section_type: 'count_area')
    @bs = Managesection.find_by(section_type: 'boy-sale-area')
    # byebug
    # @featured_properties=Managesection.find_by(section_type: 'featured')
    # 
    @featured_section = Managesection.find_by(section_type: 'featured')

    if @featured_section.present?
      ids = @featured_section.content["featured_property_ids"] || []
      @featured_properties = Property.with_attached_images.where(id: ids)
    else
      @featured_properties = []
    end
    # @featured_properties = Property.with_attached_images
    #           .where(is_featured_product: true)
    #           .order(created_at: :desc)
    #           .limit(8)
    # byebug
    @properties = @properties.paginate(page: params[:page], per_page: params[:per_page] || 6)
    respond_to do |format|
      format.html
      format.js
    end
  end


  


  def contact
   
    @contactpages = Managesection.find_by(section_type: "contact")
    # byebug
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

  def user_booked_property
    @books = current_user.books
    .includes(booking_items: { property: :user })
    .where(status: "sold")
    
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

  private

  def sanitize_q_params
    return unless params[:q]
    params[:q].delete_if { |_, v| v.blank? }
  end
  
end


# def home
#   @properties = Property.all

#   if params[:keyword].present?
#     @properties = @properties.where(
#       "name ILIKE :q OR description ILIKE :q",
#       q: "%#{params[:keyword]}%"
#     )
#   end

#   if params[:status].present?
#     @properties = @properties.where("LOWER(status) = ?", params[:status].downcase)
#   end

#   if params[:city].present?
#     @properties = @properties.where(city: params[:city])
#   end

#   if params[:fireplace] == "1"
#     @properties = @properties.where(fireplace: true)
#   end

#   if params[:swimmingpool] == "1"
#     @properties = @properties.where(swimmingpool: true)
#   end

#   @featured_properties =
#     Property.with_attached_images
#             .where(is_featured_product: true)
#             .order(created_at: :desc)
#             .limit(8)

#   respond_to do |format|
#     format.html
#     format.js
#   end
# end
