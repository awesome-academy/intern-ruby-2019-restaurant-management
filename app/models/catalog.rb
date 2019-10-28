class Catalog < ApplicationRecord
  CATALOG_PARAMS = %i(name description image).freeze
  CATALOG_LOAD_PARAMS = %i(id name description image).freeze

  has_many :posts, dependent: :destroy

  mount_uploader :image, ImageUploader

  validates :name, presence: true, length: {maximum: Settings.models.catalogs.name}, uniqueness: true
  validates :description, length: {maximum: Settings.models.catalogs.description}
  validates :image, file_size: {less_than_or_equal_to: Settings.models.photos.size.megabytes}

  scope :get_catalog, ->{select(CATALOG_LOAD_PARAMS).order(:name)}

  def titleize_name
    self.name.titleize
  end
end
