require 'open-uri'

class UsersController < ApplicationController
  skip_before_filter :authorize, only: [:index, :show, :new, :create, :avatar]
  caches_action :avatar, expires_in: 1.hour
  before_filter :set_content_type, only: [:avatar]

  def index
    @users = User.order(:created_at)
  end

  def show
    @user = User.find(params[:id])
  end
  
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

  def avatar
    user = User.find(params[:id])
    source = open("http://s3.amazonaws.com/MinecraftSkins/#{user.username}.png") { |f| f.read }
    img = ChunkyPNG::Image.from_blob source
    @avatar = ChunkyPNG::Image.new 16, 32
    @avatar.compose! img.crop(8, 8, 8, 8), 4, 0
    @avatar.compose! img.crop(20, 20, 8, 12), 4, 8
    @avatar.compose! img.crop(44, 20, 4, 12), 0, 8
    @avatar.compose! img.crop(44, 20, 4, 12).flip_vertically.resample(4, 12), 12, 8
    @avatar.compose! img.crop(4, 20, 4, 12), 4, 20
    @avatar.compose! img.crop(4, 20, 4, 12).flip_vertically.resample(4, 12), 8, 20
    
    @avatar.compose! img.crop(40, 8, 8, 8), 4, 0
    render text: @avatar.resample(32, 64).to_blob

    rescue

    render text: open('public/player.png', 'rb').read
  end

  protected

  def set_content_type
    response.headers["Content-Type"] = "image/png"
  end
end
