class CreateItemStates < ActiveRecord::Migration[5.2]
  def change
    create_table :item_states do |t|
      t.string :state, null: false
      t.timestamps
    end
  end
end
