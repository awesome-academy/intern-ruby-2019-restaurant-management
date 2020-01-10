class User < ApplicationRecord
  has_many :books, class_name: Booking.name, dependent: :destroy
  has_many :tables, through: :books
  has_many :posts, dependent: :destroy
  has_many :vouchers, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, length: {maximum: Settings.models.users.length_name}
  validates :phone, presence: true, format: {with: Settings.models.users.regex_phone, message: I18n.t("messages.phone")},
    length: {minimum: Settings.models.users.min_length_phone, maximum: Settings.models.users.max_length_phone}
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable

  scope :get_user_email, ->{select(:id, :email).order(:email)}

  enum role: [:member, :staff, :admin]

  def titleize_name
    self.name.titleize
  end
end
