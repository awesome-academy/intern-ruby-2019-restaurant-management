class Food < ApplicationRecord
  FOOD_PARAMS = %i(name description price cost status_food).freeze

  scope :check_food, ->(){where("status_food = 0").limit(8)}
  enum status_food: [:yes, :no]

  validates :name, presence: true, uniqueness: true, length: {maximum: Settings.models.foods.name}
  validates :description, presence: true
  validates :price, presence: true
  validates :cost, presence: true

  def titleize_name
    self.name.titleize
  end
end
