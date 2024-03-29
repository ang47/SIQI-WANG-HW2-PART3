class PostsController < ApplicationController

	before_filter :authenticate, :except=> [:index, :show]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
      format.xml { render xml: @posts }
      format.atom #index.atom.builder
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
	@owner = Post.find(params[:id]).owner
	@cur_owner=params[:post][:owner]
    respond_to do |format|
       if @owner == @cur_owner && @post.update_attributes(params[:post]) 
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
       else
        format.html do 
			@error='The post can only be editted by the Author'
			render action: "edit"
		end
        format.json { render json: @post.errors, status: :unprocessable_entity }
       end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])   
		@post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
  
  private
  def authenticate
	authenticate_or_request_with_http_basic do |name, password|
		name == "siqiwang" && password =="siqiwang"
	end

  end
  def auth?
    post_owner=Post.find_by_id(params[:id]).owner
    params[:post][:owner] == post_owner
  end

end
