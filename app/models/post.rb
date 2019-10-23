class Post < ApplicationRecord
  POST_PARAMS = %i(title content).freeze

  belongs_to :catalog
  belongs_to :user

  validates :title, presence: true, length: {maximum: Settings.models.posts.title}, uniqueness: true
  validates :content, presence: true
  validates :catalog_id, presence: true

  def titleize_title
    self.title.titleize
  end
end
