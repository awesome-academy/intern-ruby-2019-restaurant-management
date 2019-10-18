class Table < ApplicationRecord
  validates :type_table, presence: true
  validates :description, presence: true, length: {maximum: Settings.models.tables.description}
  enum type_table: [:single ,:couple, :family, :meeting]
end