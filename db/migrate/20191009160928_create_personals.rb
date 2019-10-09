class CreatePersonals < ActiveRecord::Migration[5.2]
  def change
    create_table :personals do |t|
      t.string :last_name ,null: false
      t.string :first_name ,null: false
      t.string :last_name_kana ,null: false
      t.string :first_name_kana ,null: false
      t.string :zip_code
      t.integer :prefecture_id
      t.string :city
      t.string :address
      t.string :building
      t.string :cellular_phone_number
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
