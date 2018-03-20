class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # protect_from_forgery with: :exception
  before_action :sanitize_devise_params, :authenticate_user!, if: :devise_controller?

  def sanitize_devise_params
  	devise_parameter_sanitizer.permit(:sign_up , keys: [:name, :image])
  	devise_parameter_sanitizer.permit(:account_update , keys: [:name, :image])
  	
  end

  def layout_by_resource
  	if devise_controller? && resource_name == :user && action_name == 'new'
      "devise"
    else
      "application"
    end
  end
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || root_path
  end
  

end
