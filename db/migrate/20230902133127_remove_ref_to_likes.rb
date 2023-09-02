class RemoveRefToLikes < ActiveRecord::Migration[7.0]
  def change
    remove_reference :likes, :user, index: true, foreign_key: true
  end
end
