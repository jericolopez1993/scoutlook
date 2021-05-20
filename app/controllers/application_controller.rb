class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pundit
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user
  before_action :set_current_action
  before_action :get_logs_and_reminders
  layout :layout_by_resource
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # rescue_from I18n::InvalidLocaleData
  helper_method :is_mobile

  def set_current_user
    if current_user
      User.current = current_user
    else
      User.current = nil
    end
  end

  def get_logs_and_reminders
    @global_summary = GlobalSummary.first
    @reminder_total = @global_summary.reminder_total
    @current_reminders = []
    @current_logs = []

    # if current_user && current_user.has_role?(:carrier_development)
    #   reminders = Reminder.listings.where(:user_id => current_user.id).order("reminder_date DESC")
    #   @reminder_total = reminders.size
    #   @current_reminders = reminders.limit(10)
    # end

    if @global_summary.reminder_ids != "[]" && @current_reminders.size == 0
      @current_reminders = Reminder.listings.where("reminders.id IN (#{@global_summary.reminder_ids.tr('[]', '')})")
    end

    if @global_summary.log_ids != "[]"
      @current_logs = Log.overall.where("logs.id IN (#{@global_summary.log_ids.tr('[]', '')})")
    end
  end

  def set_current_action
    if params[:action]
      User.current_action = params[:action]
    else
      User.current_action = nil
    end
  end

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

    def is_mobile
      request.user_agent =~ /\b(Android|iPhone|Windows Phone|Opera Mobi|Kindle|BackBerry)\b/i
    end


    protected
    def after_sign_in_path_for(resource)
      if current_user.has_role?(:admin)
        request.env['omniauth.origin'] || stored_location_for(resource) || authenticated_root_path
      else
        authenticated_root_path
      end
    end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar, :position, :phone_number, :direct_number, :toll_free])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar, :position, :phone_number, :direct_number, :toll_free])
  end

end
