class RemoveRefToComments < ActiveRecord::Migration[7.0]
  def change
    remove_reference :comments, :user, index: true, foreign_key: true
  end
end
