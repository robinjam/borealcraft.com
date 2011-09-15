class HeadlinesController < ApplicationController
  skip_before_filter :authorize, only: [ :index, :show ]
  
  # GET /posts
  # GET /posts.json
  def index
    @headlines = Headline.order("created_at DESC").paginate(page: params[:page], per_page: 5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @headlines }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @headline = Headline.find(params[:id])
    @commentable = @headline

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @headline }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @headline = Headline.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @headline }
    end
  end

  # GET /posts/1/edit
  def edit
    @headline = Headline.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @headline = Headline.new(params[:headline])

    respond_to do |format|
      if @headline.save
        format.html { redirect_to @headline, notice: 'Post was successfully created.' }
        format.json { render json: @headline, status: :created, location: @headline }
      else
        format.html { render action: "new" }
        format.json { render json: @headline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @headline = Headline.find(params[:id])

    respond_to do |format|
      if @headline.update_attributes(params[:headline])
        format.html { redirect_to @headline, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @headline.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /posts/1/delete
  def delete
    @headline = Headline.find(params[:id])
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @headline = Headline.find(params[:id])
    @headline.destroy

    respond_to do |format|
      format.html { redirect_to headlines_url }
      format.json { head :ok }
    end
  end
end
