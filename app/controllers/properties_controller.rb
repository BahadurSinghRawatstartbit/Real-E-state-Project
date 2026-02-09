class PropertiesController < ApplicationController
    before_action :set_property , only: [:show,:edit,:update]
    before_action :require_user, except: [:index,:show]
    before_action :require_admin_or_agent, only: %i[new create edit update destroy]
    before_action :block_login_routes

# before_action :set_property , only: [:show,:edit,:update, :destroy]
#     before_action :require_user, except: [:index,:show]
  def index
    @q = Property.ransack(params[:q])
    

    @properties = @q.result(distinct: true)


    if params[:sort].present?
      sort_column = params[:sort] == "property_price" ? "price" : "completiondate"
      sort_order = %w[ASC DESC].include?(params[:order]) ? params[:order] : "DESC"
      
      if sort_column == "price"
        @properties = @properties.order(Arel.sql("CAST(price AS INTEGER) #{sort_order}"))
      else
        @properties = @properties.order("#{sort_column} #{sort_order}")
      end
    else
    
      @properties = @properties.order(created_at: :desc)
    end

  
    @properties = @properties.paginate(page: params[:page], per_page: params[:per_page] || 3)
    
    @recommended_properties = Property.where(is_featured_product: true).limit(4)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    
    @property=Property.new
  end

  def edit
    
  end
 
def block_login_routes
  if logged_in? && request.path.in?([login_path, login_admin_path, login_agent_path])
    redirect_if_logged_in
  end
end

  def update
    if @property.user.nil?
      @property.user = current_user
    end
    

    if @property.update(property_params)
      
      redirect_to @property, notice: "Property updated successfully"
    else
      render :edit
    end
  end

  def create
    @property = Property.new(property_params)
    @property.user = current_user if current_user.admin? || current_user.agent?
    
    if current_user.admin?
      respond_to do |format|
        if @property.save
          
          # byebug
          format.html { redirect_to admin_dashboard_path, notice: "Property created successfully" }
          format.js
        else
          format.html { render :new }
          format.js
        end
      end
    else
      respond_to do |format|
        if @property.save
          
          # byebug
          format.html { redirect_to agent_dashboard_path_path, notice: "Property created successfully" }
          format.js
        else
          format.html { render :new }
          format.js
        end
      end
    end
    
    
  end

  def show
    
  end

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    respond_to do |format|
     format.js 
    end
    
  end

  def set_property
    @property=Property.find(params[:id])
    @properties = Property.all
  
  
  # Add search filtering logic here based on params
  if params[:keyword].present?
    @properties = @properties.where("name LIKE ? OR description LIKE ?", 
                                   "%#{params[:keyword]}%", 
                                   "%#{params[:keyword]}%")
  end
  
  if params[:status].present?
    @properties = @properties.where(status: params[:status])
  end
  
  # Filter by address/city
  if params[:city].present?
    @properties = @properties.where("address LIKE ?", "%#{params[:city]}%")
  end
  if params[:state].present?
    @properties = @properties.where("address LIKE ?", "%#{params[:state]}%")
  end
  
  # Filter by boolean attributes
  if params[:fireplace] == "1"
    @properties = @properties.where(fireplace: true)
  end
  
  if params[:swimmingpool] == "1"
    @properties = @properties.where(swimmingpool: true)
  end
    @recommended_properties = Property.where(is_featured_product: true).limit(4)

  end
  private

  
  def property_params
  params.require(:property).permit(
    :name,
    :status,
    :description,
    :address,
    :state,
    :city,
    :phonenumber,
    :soldate,
    :completiondate,
    :is_featured_product,
    :bedroom,
    :bathroom,
    :gerage,
    :area,
    :size,
    :price,
    :swimmingpool,
    :laundryroom,
    :twostories,
    :energencyexit,
    :fireplace,
    :jogpath,
    :ceilings,
    :dualsinks,
    :videoone,
    :videotwo,
    :videothree,
    :discounts,
    :rating,
    images: []
  )
  end

end
