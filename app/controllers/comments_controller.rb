class CommentsController < ApplicationController
  skip_before_filter :authorize, only: [:index, :create]

  def index
    redirect_to parent_url(parent_object)
  end
  
  def create
    unless logged_in?
      flash.keep
      redirect_to parent_url(@commentable), alert: 'You must be logged in to do that.'
      return
    end
    
    @commentable = parent_object
    @comment = @commentable.comments.build(params[:comment])
    @comment.user = current_user

    if @commentable.try(:locked?) && !admin?
      redirect_to @commentable, alert: "You are not authorized to post on locked threads."
      return
    end

    if @comment.save
      redirect_to parent_url(@commentable), notice: "Your comment was posted successfully."
    else
      render :action => 'new'
    end
  end

  private

  def parent_object
    case
      when params[:headline_id] then Headline.find(params[:headline_id])
      when params[:screenshot_id] then Screenshot.find(params[:screenshot_id])
      when params[:topic_id] then Topic.find(params[:topic_id])
    end
  end  

  def parent_url(parent)
    case
      when params[:headline_id] then headline_url(parent)
      when params[:screenshot_id] then screenshot_url(parent)
      when params[:topic_id] then topic_url(parent)
    end
  end
end
