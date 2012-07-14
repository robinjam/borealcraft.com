class SessionsController < ApplicationController
  skip_before_filter :authorize
  
  def create
    user = User.find_by_username(params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_back notice: "Thank you for logging in, #{user.username}."
    else
      redirect_back alert: 'Incorrect username or password.'
    end
  end

  def destroy
    session.delete :user_id
    redirect_back notice: "You have logged out."
  end
end
