class UsersController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Thank you for registering! Your account was created successfully.'
    else
      render :new
    end
  end
end
