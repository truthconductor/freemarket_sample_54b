class AddIndexToBrandsName < ActiveRecord::Migration[5.2]
  def change
    add_index :brands, :name
  end
end
