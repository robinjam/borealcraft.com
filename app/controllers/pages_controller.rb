class PagesController < ApplicationController
  skip_before_filter :authorize, only: [ :show ]
  
  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(params[:page])

    @page.save ?
      redirect_to(@page, notice: 'Page was successfully created.') :
      render(:new)
  end

  def update
    @page = Page.find(params[:id])

    @page.update_attributes(params[:page]) ?
      redirect_to(@page, notice: 'Page was successfully updated.') :
      render(:edit)
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    redirect_to root_url, notice: 'Page was successfully destroyed.'
  end
end
