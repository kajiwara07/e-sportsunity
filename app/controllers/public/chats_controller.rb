class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @post = Post.new
    @chats = Chat.all
    @user = current_user
  end

  def show
    @post = Post.new
    @chat = Chat.find(params[:id])
    @user = @chat.owner
    @chat = Chat.includes(chat_messages: :user).find(params[:id]) 
  end

  def create
    @chat = Chat.new(chat_params)
    @chat.owner_id = current_user.id
     @chat.user_id = current_user.id
    if @chat.save!
      redirect_to chats_path
    else
      render 'new'
    end
  end

  def new
    @chat = Chat.new
  end

  def edit
    @chat = Chat.find(params[:id])
  end

  def update
    if @chat.update(chat_params)
      redirect_to chats_path
    else
      render 'edit'
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:name, :introduction, :chat_image)
  end

  def ensure_correct_user
    @chat = Chat.find(params[:id])
    unless @chat.owner_id == current_user.id
      redirect_to chats_path
    end
  end
end
