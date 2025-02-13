class AddDefaultsToPosts < ActiveRecord::Migration[7.0]
  def change
    change_column_default :posts, :likes, 0
  end
end
