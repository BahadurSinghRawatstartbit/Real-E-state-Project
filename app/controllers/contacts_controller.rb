class ContactsController < ApplicationController
  before_action :require_admin , except: [:new]
  def new
    @contact = Contact.new
  end


  def create
    @contact = Contact.new(contact_parms)
    @contact.user = current_user
    # byebug
    if @contact.save
      # UserMailer.contact_form_submission(@contact).deliver_now
      flash[:notice] = "Message sent!"
      redirect_to pages_contact_path
    else
      flash.now[:alert] = "Could not send message"
      redirect_to pages_contact_path
    end
  end

#   def contact_submit
#   name = "#{params[:firstname]} #{params[:lastname]}"
#   email = params[:email]
#   subject = params[:subject]
#   message = params[:message]

#   if name.present? && email.present? && message.present?

#     section = Managesection.find_or_create_by(section_type: "contact_messages")
#     # UserMailer.contact_form_submission(name, email, subject, message).deliver_now
#     messages = section.content["messages"] || []

#     messages << {
#       name: name,
#       email: email,
#       subject: subject,
#       message: message,
#       created_at: Time.current
#     }

#     section.update(content: { "messages" => messages })

#     flash[:notice] = "Thank you #{name}! Your message has been sent successfully."

#   else
#     flash[:alert] = "Please fill in all required fields"
#   end

#   redirect_to pages_contact_path
# end

private
def contact_parms
  params.require(:contact).permit(:firstname,:lastname,:email,:subject,:message)
end

 
end