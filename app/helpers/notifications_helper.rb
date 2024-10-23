module NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "ChatMessage"
      "グループに参加している#{notification.notifiable.user.name}さんが#{notification.notifiable.chat.name}に投稿しました"
    else
    #   "投稿した#{notification.notifiable.book.title}が#{notification.notifiable.user.name}さんにいいねされました"
    end
  end
end