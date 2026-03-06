class ManagesectionsController < ApplicationController
   before_action :require_admin
  def index
    @sections = Managesection.all
  end

  def show
    @section = Managesection.find(params[:id])
    
  end

  def new
    
    @section = Managesection.new(section_type: params[:section_type])
    @properties=Property.all
    respond_to do |format|
      format.html # renders new.html.erb
      format.js   # renders new.js.erb (THIS MUST BE HERE)
    end
      
    
  end
  def create
    @section = Managesection.new(section_params)
    # byebug
    if @section.save
       mark_featured_properties(@section)
      redirect_to managesections_path, notice: "Section created successfully"
    else
      render :new
    end
  end

  def edit
    @section = Managesection.find(params[:id])

    @properties=Property.all
    # respond_to do |format|
    #   format.html 
    #   format.js   
    # end
  end

  def update
    @section = Managesection.find(params[:id])
    if @section.update(section_params)
      mark_featured_properties(@section)
      redirect_to managesections_path, notice: "Section updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @section = Managesection.find(params[:id])
    @section.destroy
    respond_to do |format|
     format.js 
    end
  end

  
  #  def contact_submit
  #   name = params[:firstname] + " " + params[:lastname]
  #   email = params[:email]
  #   subject = params[:subject]
  #   message = params[:message]
    
  #   if name.present? && email.present? && message.present?
  #     # UserMailer.contact_form_submission(name, email, subject, message).deliver_now
  #     flash[:notice] = "Thank you #{name}! Your message has been sent successfully."
  #   else
  #     flash[:alert] = "Please fill in all required fields"
  #   end
    
  #   redirect_to pages_contact_path
    
  # end
  
  private
  def mark_featured_properties(section)
  # Reset all properties
  Property.update_all(is_featured_product: false)
  
  # Mark selected properties as featured
  if section.content["featured_property_ids"].present?
    Property.where(id: section.content["featured_property_ids"]).update_all(is_featured_product: true)
  end
end

  def section_params
    params.require(:managesection).permit(
      :section_type,
      :title,
      :subtitle,
      :active,
      content: {},
      contact_info: {},
      images: []
      
    )
  end
end