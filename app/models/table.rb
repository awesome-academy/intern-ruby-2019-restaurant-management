class Table < ApplicationRecord
  TABLE_PARAMS = %i(description type_table).freeze
  TABLE_LOAD_PARAMS = %i(id description type_table status_table).freeze

  has_many :books, class_name: Booking.name, dependent: :destroy
  has_many :users, through: :books

  validates :description, presence: true, length: {maximum: Settings.models.tables.description}
  validates :status_table, presence: true
  validates :type_table, presence: true

  scope :get_table, ->{select(TABLE_LOAD_PARAMS)}

  enum type_table: [:single ,:couple, :family, :meeting]
  enum status_table: [:free, :busy, :booked]
end
