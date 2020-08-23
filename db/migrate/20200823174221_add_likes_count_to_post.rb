class AddLikesCountToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :likes_count, :integer, default: 0, null: false
    add_index :posts, [:likes_count, :created_at], order: { created_at: :desc, likes_count: :desc }
  end
end
