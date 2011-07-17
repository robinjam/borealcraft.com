class NewsPostsController < ApplicationController
  before_filter :authorize, except: [ :index, :show ]
  helper_method :num_pages
  
  # GET /posts
  # GET /posts.json
  def index
    @page = params[:page] ? params[:page].to_i : 1

    redirect_to news_posts_url and return if @page < 1 or @page > num_pages
    
    @news_posts = NewsPost.order("created_at DESC").limit(5).offset((@page - 1) * 5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news_posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @news_post = NewsPost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news_post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @news_post = NewsPost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news_post }
    end
  end

  # GET /posts/1/edit
  def edit
    @news_post = NewsPost.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @news_post = NewsPost.new(params[:news_post])

    respond_to do |format|
      if @news_post.save
        format.html { redirect_to @news_post, notice: 'Post was successfully created.' }
        format.json { render json: @news_post, status: :created, location: @news_post }
      else
        format.html { render action: "new" }
        format.json { render json: @news_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @news_post = NewsPost.find(params[:id])

    respond_to do |format|
      if @news_post.update_attributes(params[:news_post])
        format.html { redirect_to @news_post, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @news_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /posts/1/delete
  def delete
    @news_post = NewsPost.find(params[:id])
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @news_post = NewsPost.find(params[:id])
    @news_post.destroy

    respond_to do |format|
      format.html { redirect_to news_posts_url }
      format.json { head :ok }
    end
  end

  protected

  def num_pages
    NewsPost.order("created_at DESC").count / 5 + 1
  end
end
