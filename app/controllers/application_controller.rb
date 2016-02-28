class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_locale

  helper_method :logged_in?, :current_user
  add_flash_types :success
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActiveSupport::MessageVerifier::InvalidSignature, with: :render_error

  def render_404
    render file: 'public/404.html', status: :not_found, layout: false
  end

  def render_error
    render file: 'public/500.html', status: :internal_server_error, layout: false
  end

  def logged_in?
    current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
  end

  def require_user
    if current_user
      true
    else
      redirect_to new_user_session_path, notice: 'You must be logged in to access that page.'
    end
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    Rails.application.routes.default_url_options[:locale]= I18n.locale
  end
end
