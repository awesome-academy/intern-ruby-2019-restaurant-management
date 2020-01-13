class Voucher < ApplicationRecord
  VOUCHER_PARAMS = %i(start_time end_time).freeze

  belongs_to :user
  belongs_to :discount

  delegate :name, to: :discount, prefix: :discount
  delegate :discount_value, to: :discount, prefix: :discount

  validates :start_time, presence: true, date: {after_or_equal_to: Time.current + 7.hour, before_or_equal_to: :end_time}
  validates :end_time, presence: true, date: {after_or_equal_to: :start_time}
  validates :number, presence: true, numericality: {only_integer: true, less_than: Settings.models.vouchers.number}
end
