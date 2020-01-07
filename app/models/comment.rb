class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :parent, class_name: Comment.name, optional: true
  has_many :sub_comments, class_name: Comment.name, dependent: :destroy, foreign_key: :parent_id

  validates :content, presence: true, length: {maximum: Settings.models.comments.content}
end
