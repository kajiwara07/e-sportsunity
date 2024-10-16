class Public::ChatsController < ApplicationController
   before_action :authenticate_user!
   before_action :ensure_correct_user, only: [:edit, :update]
    
    def index
        @post = Post.new
        @chat = Chat.all
        @user = User.find(current_user.id)
    end
    def show
       @post = Post.new
       @chat = Chat.find(params[:id])
       @user = User.find(params[:id])
    end
    def create
       @chat = Chat.new(group_params)
       @chat.owner_id = current_user.id
       if @chat.save
           redirect_to groups_path, method: :post
       else
          render 'new'
       end
    end
    def new
        @chat = Chat.new
    end
    def edit 
    end
    
    def update
        if @chat.update(chat_params)
          redirect_to chats_path
        else
          render 'edit'
        end
    end
    
    private
    
    def group_params
        params.require(:chat).permit(:title, :introduction, :group_image)
    end
    def ensure_correct_user
        @chat = Chat.find(params[:id])
        unless @chat.owner_id == current_user.id
         redirect_to chats_path
        end
    end
end
