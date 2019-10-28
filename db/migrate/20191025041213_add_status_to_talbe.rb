class AddStatusToTalbe < ActiveRecord::Migration[5.2]
  def change
    add_column :tables, :status_table, :integer, default: 0
  end
end
