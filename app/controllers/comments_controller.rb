class CommentsController < ApplicationController
  before_action :wrong_url, only: [:new, :show]
  before_action :logged_as_user, only: :create
  before_action :correct_user,   only: [:destroy, :edit, :update]

  def index
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    refresh_comments
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
    refresh_comments
    flash_message
    respond_to do |format|
      format.js
      format.html {render @post}
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id])
    comment.destroy

    @post = Post.find(params[:post_id])
    refresh_comments

    respond_to do |format|
      format.js
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

    def wrong_url
      redirect_to root_path
    end

    def correct_user
      comment = Comment.find_by(id: params[:id])
      redirect_to login_path unless (current_user == User.find_by(id: comment.user_id))
    end

    def refresh_comments
      @comments = @post.comments.paginate(page: params[:page], per_page: 10).order('id DESC')
    end
end
