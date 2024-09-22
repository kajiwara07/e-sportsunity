class Post < ApplicationRecord
    belongs_to :user
    has_one_attached :image
      validates :title, presence: true
      validates :body, presence: true
      validates :title, length: { in: 1..75 }
      validates :body, length: { in: 2..500 }
     
    def image_url
    return nil unless image.attached?
    Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
    end
end
