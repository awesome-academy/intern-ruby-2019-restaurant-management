class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.integer :parent_id

      t.timestamps
    end
    add_index :comments, [:parent_id]
  end
end
