class CreateDeliverExpends < ActiveRecord::Migration[5.2]
  def change
    create_table :deliver_expends do |t|
      t.string :expend, null: false
      t.timestamps
    end
  end
end
