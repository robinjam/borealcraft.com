class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?, :admin?
  before_filter :authorize

  protected

  # TODO: Test all of these

  def redirect_back(params)
    begin
      redirect_to :back, params
    rescue ActionController::RedirectBackError
      redirect_to root_url, params
    end
  end

  def current_user
    User.find_by_id(session[:user_id])
  end

  def logged_in?
    return !current_user.nil?
  end

  def admin?
    return current_user && current_user.admin?
  end

  def authorize
    unless admin?
      respond_to do |format|
        format.html do
          flash.keep
          redirect_to root_url, alert: 'You are not authorized to do that.'
        end
        format.json { head :unauthorized }
      end
    end
  end
end
