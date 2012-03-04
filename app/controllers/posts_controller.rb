class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  
  before_filter :authenticate_user!
  before_filter :current_user?, :only => [:edit, :update, :destroy]

  def current_user?
    @user = Post.find(params[:id]).user
    if @user != current_user
      redirect_to posts_path, :notice => "you may not access that crap"
    end
  end

  def index
    @post = Post.new
    @posts = Post.paginate(:page => params[:page], :per_page => 20).includes(:user).order('created_at DESC')
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
        format.html { redirect_to posts_path, :notice => "slam" }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { redirect_to posts_path }
        flash[:alert] = "shit."
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'slam updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
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
end
