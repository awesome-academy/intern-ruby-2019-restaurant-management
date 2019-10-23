class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name, unique: true, null: false
      t.string :description
      t.integer :status_food, default: 0
      t.float :price, limit: 53
      t.float :cost, limit: 53

      t.timestamps
    end
  end
end
