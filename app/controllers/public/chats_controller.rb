class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only: [:show, :edit, :update, :ensure_correct_user]
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_group_member, only: [:show]

  def index
    @post = Post.new
    @chats = Chat.all.includes(:users)
    @user = current_user
  end

  def show
    @post = Post.new
    @user = @chat.owner
    @login_user = current_user
    @member_count = @chat.users.count 
    @owner_included_count ||= @member_count
    @messages = @chat.chat_messages.includes(:user).where('id > ?', params[:id])
    @chat_messages = @chat.chat_messages  # チャットに関連するメッセージを取得
    @chat_message = ChatMessage.new  
  end

  def create
    @chat = Chat.new(chat_params)
    @chat.owner_id = current_user.id
    if @chat.save
     @chat.users << current_user
     flash[:notice] = 'グループが作成されました。'
     redirect_to @chat 
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
      flash[:notice] = 'グループが更新されました。'
      redirect_to chats_path
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
  def ensure_group_member
    @chat = Chat.find(params[:id])
    unless current_user == @chat.owner || @chat.users.include?(current_user)
      flash[:alert] = "このグループにアクセスする権限がありません。"
     redirect_to chats_path
    end
  end
  def ensure_correct_user
    unless @chat.owner_id == current_user.id
      redirect_to chats_path, alert: '権限がありません。'
    end
  end
end
