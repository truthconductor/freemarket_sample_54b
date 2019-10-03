class CreateDeals < ActiveRecord::Migration[5.2]
  def change
    create_table :deals do |t|
      t.datetime :date, null: false
      t.references :buyer, foreign_key: { to_table: :users }, null: false
      t.references :seller, foreign_key: { to_table: :users }, null: false
      t.timestamps
    end
  end
end
