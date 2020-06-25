class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :friend, index: true
      t.integer :status, default: 0

      t.timestamps null: false
    end
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
