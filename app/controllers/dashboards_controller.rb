class DashboardsController < ApplicationController
  before_action :require_login
  before_action :require_admin, only: [:admin_dashboard]
  before_action :require_agent, only: [:agent__dashboard]
  before_action :superuser ,only: [:allusers_agents]
  before_action :commonqueries, only:[:agent_dashboard,:agentpropertylst,:agentcustomerlst,:agentbookedpropertylst]


  def admin_dashboard; end
  def agent_dashboard
  end
  def user; end

  def allusers_agents
    @users=User.with_role(:agent)
  end
  def agentpropertylst
  
  end

  def booked_property_lst
    # @booked_properties = Property.where(status: "sold").distinct
    @sold_items = BookingItem
      .joins(book: :user)          # customer
      .joins(property: :user)      # agent
      .where(books: { status: "sold" })
      .includes(
        book: :user,
        property: :user
    )
  end

  def agentcustomerlst
  
  end

  def agentbookedpropertylst
  
  end

  

  

  def commonqueries
    @agent = current_user

    @agentproperty=@agent.properties

    @total_properties = @agent.properties.count

    
    @customers = User.joins(books: { booking_items: :property })
      .where(properties: { user_id: @agent.id })
      .distinct

    @total_customers = @customers.count
    @agent_properties=@agent.properties
      .where(status: "Sold")
      .order(created_at: :desc)
    
    @booked_properties = Property.joins(:booking_items)
      .where(user_id: @agent.id)
      .distinct

    @total_booked_properties = @booked_properties.count
  
    @total_revenue = @agent.properties
      .where(status: "Sold")
      .sum("price::integer")

    
    @recent_customers = User
      .joins(books: { booking_items: :property })
      .where(properties: { user_id: @agent.id })
      .group('users.id')
      .order('MAX(books.created_at) DESC')
      .limit(5)

    @recent_properties = @agent.properties
      .order(created_at: :desc)
      .limit(5)
  end
private
  def require_login
    redirect_to login_path unless current_user
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end

  def require_agent
    redirect_to root_path unless current_user.agent?
  end
end

