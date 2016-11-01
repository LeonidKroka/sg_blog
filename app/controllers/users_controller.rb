class UsersController < ApplicationController
  def new
    @user = User.new
    @logins = User.all.map {|user| user.login}
    @emails = User.all.map {|user| user.email}
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
  end

  private
    def user_params
      params.require(:user).permit(:login, :email, :password, :password_confirmation)
    end
end
