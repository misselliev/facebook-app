class ApplicationController < ActionController::Base
  helper_method :resource_name, :resource, :devise_mapping, :resource_class
  protect_from_forgery with: :exception

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  private
  def after_sign_in_path_for(resource)
    "/pages/aqui"
  end
end
