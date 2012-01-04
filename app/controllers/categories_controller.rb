class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    @category.save ?
      redirect_to(forums_url, notice: 'Category was successfully created.') : render(:new)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update_attributes(params[:category]) ?
      redirect_to(forums_url, notice: 'Category was successfully updated.') : render(:edit)
  end

  def delete
    @category = Category.find(params[:id])
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to forums_url, notice: 'Category was successfully destroyed.'
  end
end
