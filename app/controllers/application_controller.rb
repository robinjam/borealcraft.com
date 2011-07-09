class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :server_online?

  protected

  def server_online?
    return !`screen -ls | grep "\.minecraft"`.empty?
  end
end
