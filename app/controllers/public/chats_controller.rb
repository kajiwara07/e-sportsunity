class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only: [:show, :edit, :update, :ensure_correct_user]
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @post = Post.new
    @chats = Chat.all
    @user = current_user
  end

  def show
    @post = Post.new
    @user = @chat.owner
    @login_user = current_user
    @messages = @chat.chat_messages.includes(:user).where('id > ?', params[:id])
  end

  def create
    @chat = Chat.new(chat_params)
    @chat.owner_id = current_user.id
    @chat.user_id = current_user.id
    if @chat.save
    redirect_to @chat, notice: 'グループが作成されました。'
    else
       @user = current_user
       render :new 
    end
  end

  def new
     @chat = Chat.new
     @user = current_user 
  end

  def edit
     @chat = Chat.find(params[:id])
     @user = current_user
  end

  def update
    if @chat.update(chat_params)
      redirect_to chats_path, notice: 'グループが更新されました。'
    else
      render :edit
    end
  end

  private

  def set_chat
    @chat = Chat.includes(chat_messages: :user).find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:name, :introduction, :chat_image)
  end

  def ensure_correct_user
    unless @chat.owner_id == current_user.id
      redirect_to chats_path, alert: '権限がありません。'
    end
  end
end
