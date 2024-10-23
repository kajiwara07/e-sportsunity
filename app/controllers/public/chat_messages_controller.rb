class Public::ChatMessagesController < ApplicationController
    
  def create
  @chat_message = ChatMessage.new(chat_message_params)
  @chat_message.user = current_user
  @chat_message.chat = Chat.find(params[:chat_id])
  if @chat_message.save
    redirect_to @chat_message.chat, notice: 'メッセージが送信されました。'
  else
    @chat = @chat_message.chat
    @login_user = current_user
    render 'public/chats/show' # 適切なビューをレンダリング
  end
end


private

def chat_message_params
  params.require(:chat_message).permit(:content)
end

end
