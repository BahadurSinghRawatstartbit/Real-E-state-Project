class PropertiesController < ApplicationController
  #  def index
  #    @properties = Property.order(created_at: :desc)
  #   @recommended_properties = Property.where(is_featured_product: true).limit(4)
  #  byebug
  #  end
    before_action :set_property , only: [:show,:edit,:update, :destroy]
    before_action :require_user, except: [:index,:show]
   
  def index
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

    sort_column = case params[:sort]
                    when "property_date"  then "completiondate"
                    when "property_price" then "price"
                    else "completiondate"
                  end

  sort_order = %w[ASC DESC].include?(params[:order]) ? params[:order] : "DESC"

  if sort_column == "price"
    @properties = @properties.order(
      Arel.sql("CAST(price AS INTEGER) #{sort_order}")
    )
  else
    @properties = @properties.order("#{sort_column} #{sort_order}")
  end


  per_page = params[:per_page].presence || 3

  @properties = @properties.paginate(
    page: params[:page],
    per_page: per_page)
  @recommended_properties = Property.where(is_featured_product: true).limit(4)

  respond_to do |format|
    format.html # Renders the default HTML view
    format.js   # Renders the `index.js.erb` file
  end
  end

  def new
    
    @property=Property.new
  end

  def edit
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    if @property.update(property_params)
      redirect_to @property, notice: "Property updated successfully"
    else
      render :edit
    end
  end
  # def create
  #   # byebug
  #   @property = Property.new(property_params)

  #   if @property.save
  #     redirect_to root_path, notice: "Property created successfully"
  #   else
  #     render :new
  #   end
  #   respond_to do |format|
  #   format.js   
  #   end
  # end
  def create
  @property = Property.new(property_params)

  respond_to do |format|
    if @property.save
      format.html { redirect_to root_path, notice: "Property created successfully" }
      format.js
    else
      format.html { render :new }
      format.js
    end
  end
end

  def show
    
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

