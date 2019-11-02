class ChangeItemImagesForeinKey < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :item_images, :items
    add_foreign_key :item_images, :items, on_delete: :cascade
  end
end
