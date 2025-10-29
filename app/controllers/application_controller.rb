class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  protect_from_forgery with: :exception
  allow_browser versions: :modern

  helper_method :current_user

  def current_user
    return nil unless session[:jwt]
    decoded = JsonWebToken.decode(session[:jwt])
    @current_user ||= User.find_by(id: decoded[:user_id]) if decoded
  rescue
    nil
  end
end
