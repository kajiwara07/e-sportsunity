class AddImageToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :img, :string
  end
end
