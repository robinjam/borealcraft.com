class HeadlinesController < ApplicationController
  skip_before_filter :authorize, only: [ :index, :show ]

  respond_to :html, :atom, only: [:index]
  
  def index
    @headlines = Headline.order("created_at DESC").paginate(page: params[:page], per_page: 5)
  end

  def show
    @headline = Headline.find(params[:id])
    @commentable = @headline
  end

  def new
    @headline = Headline.new
  end

  def edit
    @headline = Headline.find(params[:id])
  end

  def create
    @headline = Headline.new(params[:headline])

    @headline.save ?
      redirect_to(@headline, notice: 'Headline was successfully created.') :
      render(:new)
  end

  def update
    @headline = Headline.find(params[:id])

    @headline.update_attributes(params[:headline]) ?
      redirect_to(@headline, notice: 'Headline was successfully updated.') :
      render(:edit)
  end

  def delete
    @headline = Headline.find(params[:id])
  end

  def destroy
    @headline = Headline.find(params[:id])
    @headline.destroy

    redirect_to headlines_url, notice: 'Headline was successfully destroyed.'
  end
end
