class Booking < ApplicationRecord
  BOOKING_PARAMS = %i(people book_at description).freeze
  BOOKING_LOAD_PARAMS = %i(id user_id checkout people book_at table_id).freeze

  belongs_to :user
  belongs_to :table

  validates :people, presence: true
  validates :checkout, presence: true
  validates :user_id, presence: true
  validates :table_id, presence: true
  validates :book_at, presence: true, date: {after_or_equal_to: Time.current}, on: :create
  validates_uniqueness_of :book_at, scope: [:user_id, :table_id]

  scope :get_booking, -> {select(BOOKING_LOAD_PARAMS).order(book_at: :desc)}
  scope :check_book_exsits, -> (table_id, time) {where("table_id = ? && book_at >= SUBTIME(?,'2:0') and book_at <= ADDTIME(?,'2:0')", table_id, time, time)}

  enum people: [:single, :couple, :family, :meeting]
  enum checkout: [:unpaid, :paid]
end
