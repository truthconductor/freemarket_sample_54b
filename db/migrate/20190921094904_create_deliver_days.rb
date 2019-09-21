class CreateDeliverDays < ActiveRecord::Migration[5.2]
  def change
    create_table :deliver_days do |t|
      t.string :day, null: false
      t.timestamps
    end
  end
end
