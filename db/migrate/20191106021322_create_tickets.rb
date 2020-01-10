class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :vouchers do |t|
      t.references :user, foreign_key: true
      t.references :discount, foreign_key: true
      t.date :start_time
      t.date :end_time
      t.integer :number, default: 1

      t.timestamps
    end
  end
end
