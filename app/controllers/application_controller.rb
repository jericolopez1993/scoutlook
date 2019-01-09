class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :set_raven_context

  private
    def set_raven_context
      Raven.user_context(id: session[:current_user_id]) # or anything else in session
      Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end

    def user_not_authorized
      flash[:error] = "You are not authorized to perform this action."
      redirect_to(request.referrer || authenticated_root_path)
    end

    def layout_by_resource
      if devise_controller?
        "devise"
      else
        "application"
      end
    end


    protected
    def after_sign_in_path_for(resource)
      if current_user.has_role?(:contact) && !current_user.shipper_contact.nil?
        shippers_path
      else
        request.env['omniauth.origin'] || stored_location_for(resource) || authenticated_root_path
      end
    end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar])
  end

end
