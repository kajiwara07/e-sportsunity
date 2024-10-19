class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_one_attached :profile_image
  has_many :comments, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :chats, through: :groups
  has_many :chat_messages
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, uniqueness: true
  validates :name, length: { minimum: 2 }
  validates :name, length: { maximum: 20 }
  
  
  def get_profile_image
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default_image.jpg', content_type: 'image/jpeg')
  end
  profile_image
  end
end