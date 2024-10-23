class Chat < ApplicationRecord
  has_many :groups, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  has_many :users, through: :groups
  has_one_attached :chat_image
  has_many :chat_messages, dependent: :destroy 
  after_create :add_owner_to_members
  
  validates :name, presence: true, length: { in: 1..20 }
  validates :introduction, presence: true, length: { in: 1..250 }

  def is_owned_by?(user)
    owner.id == user.id
  end

  def includesUser?(user)
    groups.exists?(user_id: user.id)
  end
  def user
    self.owner
  end
  def add_owner_to_members
    self.users << owner unless self.users.include?(owner)  
  end
end