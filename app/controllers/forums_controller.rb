class ForumsController < ApplicationController
  skip_before_filter :authorize, only: [:index, :show]
  
  def index
    @categories = Category.all
  end

  def show
    @forum = Forum.find(params[:id])
  end

  def new
    @category = Category.find(params[:category_id])
    @forum = @category.forums.build
  end

  def create
    @category = Category.find(params[:category_id])
    @forum = @category.forums.build(params[:forum])
    @forum.save ?
      redirect_to(forums_url, notice: 'Forum was successfully created.') : render(:new)
  end

  def edit
    @forum = Forum.find(params[:id])
  end

  def update
    @forum = Forum.find(params[:id])
    @forum.update_attributes(params[:forum]) ?
      redirect_to(forums_url, notice: 'Forum was successfully updated.') : render(:edit)
  end

  def delete
    @forum = Forum.find(params[:id])
  end

  def destroy
    Forum.find(params[:id]).destroy
    redirect_to forums_url, notice: 'Forum was successfully destroyed.'
  end
end
