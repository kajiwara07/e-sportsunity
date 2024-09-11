class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :title
      t.integer :user_id
      t.integer :chat_id
      t.timestamps
    end
  end
end
