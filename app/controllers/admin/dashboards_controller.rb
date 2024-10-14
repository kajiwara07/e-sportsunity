class Admin::DashboardsController < ApplicationController
    before_action :authenticate_admin!
    layout 'admin'
    
    def index
        @comments = Comment.all
        @users = User.all
    end
end
