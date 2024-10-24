class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.integer :owner_id
      t.string :name
      t.text :introduction

      t.timestamps
    end
  end
end
