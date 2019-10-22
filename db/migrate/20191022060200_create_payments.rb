class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.integer :amount,            null: false
      t.integer :point,             null: false
      t.references :deal,           foreign_key: true
      t.timestamps
    end
  end
end
