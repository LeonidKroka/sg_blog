class UsersController < ApplicationController
  def new
    @user = User.new
    @logins = User.all.map {|user| user.login}
    @emails = User.all.map {|user| user.email}
  end

  def create
    @user = User.new(user_params)
    @user.latitude, @user.longitude = cookies[:lat_lng].split("|")
    if @user.save
      log_in @user
      flash[:error_activation] = 'Account is not activated.' unless @user.activated
      UserMailer.account_activation(@user).deliver_now
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @activity = find_activity @user
    @posts = @user.posts.paginate(page: params[:page], per_page: 5).order('id DESC')
  end

  private
    def user_params
      params.require(:user).permit(:login, :email, :password, :password_confirmation)
    end

    def find_activity user
      {:post => user.posts.all.count,
       :comment => user.comments.all.count}
    end
end
