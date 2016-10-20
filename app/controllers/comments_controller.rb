class CommentsController < ApplicationController
  def index
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comments = @post.comments.paginate(page: params[:page], per_page: 10).order('id DESC')
    flash_message
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
    @comment = @post.comments.find(params[:id])
    @comment.update(comment_params)
    @comments = @post.comments.paginate(page: params[:page], per_page: 10).order('id DESC')
    flash_message
    respond_to do |format|
      format.js
      format.html {render @post}
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end

    def flash_message
      if @comment.errors.any?
        flash[:errors] = @comment.errors[:body].first
        flash[:body] = params[:comment][:body]
        flash[:style] = "border: 1px double red"
      else
        flash.clear
      end
    end
end
