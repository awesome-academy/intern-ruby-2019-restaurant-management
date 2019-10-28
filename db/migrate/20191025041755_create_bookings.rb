class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer :people
      t.datetime :book_at
      t.string :description
      t.integer :checkout, default: 0
      t.references :user, foreign_key: true
      t.references :table, foreign_key: true

      t.timestamps
    end
    add_index :bookings, [:book_at, :user_id, :table_id], unique: true, name: "time_booking_table"
  end
end
