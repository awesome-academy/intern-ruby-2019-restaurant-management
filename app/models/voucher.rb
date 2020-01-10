class Voucher < ApplicationRecord
  belongs_to :user
  belongs_to :discount

  validates :start_time, presence: true, date: {after_or_equal_to: Time.current + 7.hour, before_or_equal_to: :end_time}
  validates :end_time, presence: true, date: {after_or_equal_to: :start_time}
  validates :number, presence: true, numericality: {only_integer: true, less_than: Settings.models.vouchers.number}
end
