class Public::GroupsController < ApplicationController
    before_action :authenticate_user!
  def create
    @group = current_user.groups.new(chat_id: params[:chat_id])
    if @group.save
      redirect_to request.referer, notice: 'You have joined the group.'
    else
      redirect_to request.referer, alert: 'Failed to join the group.'
    end
  end
  def destroy
    @group = current_user.groups.find_by(chat_id: params[:chat_id])
    if @group
      @group.destroy
      redirect_to request.referer, notice: 'You have left the group.'
    else
      redirect_to request.referer, alert: 'Group not found or you are not part of this group.'
    end
  end
end
