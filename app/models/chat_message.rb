class ChatMessage < ApplicationRecord
  belongs_to :user
  belongs_to :chat
validates :content, presence: true
validates :content, length: { in: 1..250 }
  has_many :notifications, as: :notifiable, dependent: :destroy
after_create_commit :create_notifications

  def create_notifications
    self.chat.user.chats.where.not(user_id: self.user_id).each do |user|
      Notification.create!(
        user_id: user.user_id,  # 通知を受けるユーザー
        notifiable: self,  # 関連するチャット
      )
    end
  end
end
