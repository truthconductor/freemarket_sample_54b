class CreateCategoriesBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_brands do |t|
      t.references :category, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true
      t.timestamps
    end
  end
end
