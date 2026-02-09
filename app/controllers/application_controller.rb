class ApplicationController < ActionController::Base
  layout :set_layout_by_role
  helper_method :current_user,:require_user,:require_admin_or_agent,:redirect_if_logged_in,:require_admin,:propertyPermissions,:require_agent ,:logged_in?,:superuser ,:current_cart ,:current_agent
  def current_user
    # @current_user ||= User.find(session[:user_id]) if session[:user_id]
    return unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_agent
    return unless current_user
    current_user if current_user.has_role?(:agent)
  end


  def logged_in?
      !!current_user
  end

 
  def propertyPermissions
    current_user if current_user.admin? && current_user.agent?
  end
def require_agent
  unless logged_in? && current_user.agent?
    redirect_to root_path, alert: "Agent access only"
  end
end

def require_admin
  unless logged_in? && current_user.admin?
    redirect_to root_path, alert: "Admin access only"
  end
end

def require_admin_or_agent
  unless logged_in? && (current_user.admin? || current_user.agent?)
    redirect_to root_path, alert: "Not authorized"
  end
end


  def require_user
    return if logged_in?

    flash[:alert] = "You must be logged in to perform that action"
    redirect_to login_path
  end

  

  def superuser
    unless logged_in? && current_user.admin?
      redirect_to admin_dashboard_path, alert: "Not authorized"
    end
  end

  def redirect_if_logged_in
    return unless logged_in?

    if current_user.admin?
      redirect_to admin_dashboard_path
    elsif current_user.agent?
      redirect_to agent_dashboard_path
    else
      redirect_to root_path   
    end
  end

  


 def current_cart
  return unless current_user

  @current_cart ||= current_user.books.find_or_create_by!(
    status: "In cart"
  ) do |book|
    book.total_amount = 0
  end
 end


  private

  def set_layout_by_role
    if current_user&.admin?
      "admin_layout"
    elsif current_user&.agent?
      "agent_layout"
    else
      "application"
    end
  end


end
