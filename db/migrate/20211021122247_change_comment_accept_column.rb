class ChangeCommentAcceptColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :accept
    add_column :comments, :status,:integer, default: 0
  end
end
