class ChangeColumnsToPosts < ActiveRecord::Migration[5.0]
  def change
	remove_column :posts, :comments_count, :integer
  	add_column :posts, :commentable, :boolean
  end
end
