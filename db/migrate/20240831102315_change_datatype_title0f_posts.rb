class ChangeDatatypeTitle0fPosts < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :title, :string
  end
end
