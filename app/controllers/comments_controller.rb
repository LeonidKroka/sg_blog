class CommentsController < ApplicationController
  def index
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comments = @post.comments.paginate(page: params[:page], per_page: 10).order('id DESC')
    respond_to do |format|
      format.js
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @post = Post.find(params[:post_id])
    @post.comments.find(params[:id]).update(comment_params)
    @comments = @post.comments.paginate(page: params[:page], per_page: 10).order('id DESC')
    respond_to do |format|
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
