class Admin::ChatsController < ApplicationController
     before_action :authenticate_admin!
     layout 'admin'
     
     def destroy
        @chat = Chat.find(params[:id])
        @chat.destroy
        redirect_to admin_dashboards_path
    end
end
