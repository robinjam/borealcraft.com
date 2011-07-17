class SessionsController < ApplicationController
  skip_before_filter :authorize
  
  # POST /session
  # POST /session.json
  def create
    user = User.find_by_username params[:username]

    respond_to do |format|
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        format.html { redirect_back notice: "Thank you for logging in, #{user.username}." }
        format.json { head :ok }
      else
        format.html { redirect_back alert: 'Incorrect username or password.' }
        format.json { head :unprocessable_entity }
      end
    end
  end

  # DELETE /session
  # DELETE /session.json
  def destroy
    session.delete :user_id

    respond_to do |format|
      format.html do
        redirect_back notice: "You have logged out."
      end
      format.json { head :ok }
    end
  end
end
