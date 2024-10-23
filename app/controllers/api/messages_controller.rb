class Api::MessagesController < ApplicationController
    def index
        @chat = Chat.find(params[:group_id])
        @messages = @chat.chat_messages.includes(:user).where('id > ?', params[:id])
        respond_to do |format|
            format.html
            format.json
        end
    end
end
