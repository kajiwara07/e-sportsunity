class Public::GroupsController < ApplicationController
    before_action :authenticate_user!
  def create
    @group = current_user.groups.new(chat_id: params[:chat_id])
    if @group.save
      redirect_to request.referer
      flash[:notice] = 'グループに参加しました。。'
    else
      redirect_to request.referer
      flash[:alert] = 'グループに参加できません。'
    end
  end
  def destroy
    @group = current_user.groups.find_by(chat_id: params[:chat_id])
    if @group
      @group.destroy
      redirect_to request.referer
      flash[:notice] = 'グループを退会しました。'
    else
      redirect_to request.referer
      flash[:alert] = 'グループが見つからないか、このグループのメンバーではありません。'
    end
  end
end
