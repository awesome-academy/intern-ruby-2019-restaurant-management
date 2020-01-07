class Post < ApplicationRecord
  POST_PARAMS = %i(title content).freeze
  POST_LOAD_PARAMS = %i(id title).freeze

  belongs_to :catalog
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: {maximum: Settings.models.posts.title}, uniqueness: true
  validates :content, :catalog_id, presence: true

  scope :post_represent, ->{select(POST_LOAD_PARAMS).order(:title)}

  scope :post_represent, ->{select(POST_LOAD_PARAMS).order(:title)}

  def titleize_title
    self.title.titleize
  end
end
