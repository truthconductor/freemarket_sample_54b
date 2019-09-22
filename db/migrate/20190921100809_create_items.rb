class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,               null: false
      t.text :description,          null: false
      t.integer :amount,            null: false
      t.references :item_state,     null: false, foreign_key: true
      t.references :deliver_expend, null: false, foreign_key: true
      t.references :deliver_method, null: false, foreign_key: true
      t.integer :prefecture_id,      null: false
      t.references :deliver_day,    null: false, foreign_key: true
      t.references :sales_state,    null: false, foreign_key: true
      t.references :category,       null: false, foreign_key: true
      t.references :brand,          foreign_key: true
      t.references :deal,           foreign_key: true
      t.references :seller,         foreign_key: { to_table: :users }, null: false
      t.timestamps
    end
  end
end
