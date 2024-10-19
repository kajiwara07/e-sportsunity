class Public::ChatMessagesController < ApplicationController
    def create
  @chat = Chat.find(params[:chat_id])
  @chat_message = @chat.chat_messages.build(chat_message_params)
  @chat_message.user = current_user

  if @chat_message.save
    redirect_to chat_path(@chat)
  else
    render 'public/chats/show'
  end
end

private

def chat_message_params
  params.require(:chat_message).permit(:content)
end

end
