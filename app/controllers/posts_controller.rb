class PostsController < ApplicationController
  before_action :logged_as_user, only: [:new, :create]
  before_action :correct_user,   only: [:destroy, :edit, :update]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 5).order('id DESC')
  end

  def searching
    @posts = []
    Post.all.each {|post| @posts<<post if post.title.include?(params[:post][:title])}
    session[:search] = params[:post][:title]
    render 'search'
  end

  def search
    @posts = []
    Post.all.each {|post| @posts<<post if post.title.include?(session[:search])}
    render 'search'
  end

  def show
    @post = Post.find(params[:id])
    @author = User.find_by(id: @post.user_id)
    @comments = @post.comments.paginate(page: params[:page], per_page: 10).order('id DESC')
    flash.clear
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.remove_image! if params.require(:post).require(:remove_image).to_i==1

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.remove_image!
    @post.destroy

    redirect_to "/"
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :image, :user_id)
    end

    def correct_user
      post = Post.find_by(id: params[:id])
      redirect_to login_path unless (current_user == User.find_by(id: post.user_id))
    end
end
