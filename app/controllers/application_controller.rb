class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    if current_user.roles.first.name == "admin"
      users_path
    else
      if current_user.customer_id.nil?
        requests_path(notice: "Welcome to apply shootstay!")
      else
        requests_path(notice: "Welcome to apply shootstay!")
      end
    end
  end

end