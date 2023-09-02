class AddDefaultToLikesCounter < ActiveRecord::Migration[7.0]
  def change
    change_column_default :posts, :LikesCounter, 0
  end
end
