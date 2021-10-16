class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :user_id
      t.integer :post_id
      t.boolean :accept, default: false

      t.timestamps
    end
  end
end
