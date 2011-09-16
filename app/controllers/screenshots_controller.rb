class ScreenshotsController < ApplicationController
  skip_before_filter :authorize
  
  def index
    @screenshots = Screenshot.order("created_at DESC").paginate(page: params[:page], per_page: 12)
  end

  def new
    flash.keep and redirect_to(root_path, alert: 'You must be logged in to upload screenshots.') and return unless logged_in?
    @screenshot = Screenshot.new
  end

  def create
    flash.keep and redirect_to(root_path, alert: 'You must be logged in to upload screenshots.') and return unless logged_in?
    
    @screenshot = Screenshot.new(params[:screenshot])
    @screenshot.user = current_user
    if @screenshot.save
      redirect_to @screenshot, notice: 'Your screenshot was uploaded successfully.'
    else
      render :new
    end
  end

  def show
    @screenshot = Screenshot.find(params[:id])
    @commentable = @screenshot
  end

  def edit
    @screenshot = Screenshot.find(params[:id])
    flash.keep and redirect_to(root_path, alert: 'You are not authorized to edit that screenshot.') and return unless logged_in? && (admin? || current_user == @screenshot.user)
  end

  def update
    @screenshot = Screenshot.find(params[:id])
    flash.keep and redirect_to(root_path, alert: 'You are not authorized to edit that screenshot.') and return unless logged_in? && (admin? || current_user == @screenshot.user)
    if @screenshot.update_attributes(params[:screenshot])
      redirect_to @screenshot, notice: 'Your screenshot was updated successfully.'
    else
      render :edit
    end
  end

  def delete
    @screenshot = Screenshot.find(params[:id])
    flash.keep and redirect_to(root_path, alert: 'You are not authorized to delete that screenshot.') and return unless logged_in? && (admin? || current_user == @screenshot.user)
  end

  def destroy
    @screenshot = Screenshot.find(params[:id])
    flash.keep and redirect_to(root_path, alert: 'You are not authorized to delete that screenshot.') and return unless logged_in? && (admin? || current_user == @screenshot.user)
    @screenshot.destroy
    redirect_to screenshots_path, notice: 'Your screenshot has been deleted.'
  end
end
