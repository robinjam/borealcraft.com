class TopicsController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create, :show]
  
  def new
    @forum = Forum.find(params[:forum_id])
    
    unless logged_in?
      flash.keep
      redirect_to @forum, alert: 'You must be logged in to do that.'
    end
    
    @topic = @forum.topics.build
    @topic.comments.build
  end

  def create
    @forum = Forum.find(params[:forum_id])
    
    unless logged_in?
      flash.keep
      redirect_to @forum, alert: 'You must be logged in to do that.'
    end
    
    @topic = @forum.topics.build(params[:topic])
    @comment = @topic.comments.build(params[:comment])
    @comment.user = current_user
    @topic.save ?
      redirect_to(@topic, notice: 'Thread created successfully.') : render(:new)
  end

  def show
    @topic = Topic.find(params[:id])
    @commentable = @topic
  end
end
