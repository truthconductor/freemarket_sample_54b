class ItemImage < ApplicationRecord
  #Validation
  # validates :image, presence: true

  belongs_to :item
  mount_uploader :image, ItemImageUploader
end