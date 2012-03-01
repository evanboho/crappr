class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end
  
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all
  end
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    @comment.user_id = @post.user.id
    if @comment.save
      flash[:notice] = "Comment posted"
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end
  
  def show
    # @post = Post.find(params[:post_id])
    #    @comments = @post.comments.all
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
end