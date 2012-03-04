class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comment.build
  end
  
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all
  end
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "Comment posted"
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post), :alert => "shit"
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
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to @post
  end
  
end