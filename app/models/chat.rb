class Chat < ApplicationRecord
 has_many :groups, dependent: :destroy
 belongs_to :owner, class_name: 'User'
 has_many :users, through: :groups
 has_one_attached :chat_image
 belongs_to :user
 has_many :chat_messages
    
 validates :name, presence: true
 validates :introduction, presence: true
 
 def is_owned_by?(user)
     owner.id == user.id
 end
 
end
