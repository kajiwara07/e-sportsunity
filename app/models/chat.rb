class Chat < ApplicationRecord
  has_many :groups, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  has_many :users, through: :groups
  has_one_attached :chat_image
  has_many :chat_messages, dependent: :destroy 
  
  validates :name, presence: true, length: { in: 1..20 }
  validates :introduction, presence: true, length: { in: 1..250 }

  # チャットの所有者がユーザーか確認する
  def is_owned_by?(user)
    owner.id == user.id
  end

  # グループ内にユーザーが含まれているか確認する
  def includesUser?(user)
    groups.exists?(user_id: user.id)
  end
  def user
    self.owner
  end
end