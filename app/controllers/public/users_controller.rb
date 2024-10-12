class Public::UsersController < ApplicationController
  before_action :require_login
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def show 
    @user = current_user
    @posts = @user.posts.all.order(created_at: :desc)
  end

  def edit
    @user = current_user
  end

  def update
      @user = current_user # ここで@userを設定
    if @user.update(user_params)
      redirect_to posts_path, notice: 'ユーザー情報が更新されました。'
    else
      render :edit
    end
  end
  def destroy
      current_user.destroy
      sign_out
      redirect_to  root_path, notice: '退会しました。'
  end

  private

  def require_login
    unless current_user
      redirect_to login_path, alert: "ログインしてください"
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to mypage_path
    end
  end
end