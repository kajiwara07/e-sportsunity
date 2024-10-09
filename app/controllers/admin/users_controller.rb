class Admin::UsersController < ApplicationController
    before_action :authenticate_admin!
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
    end
    
    def admin_params
      params.require(:admin).permit(:name, :email, :password, :password_confirmation, :profile_image)
    end
end
