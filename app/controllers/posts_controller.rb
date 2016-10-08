class PostsController < ApplicationController
  def index
    @posts = Post.latest_five
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

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
      params.require(:post).permit(:title, :body, :image)
    end

end
