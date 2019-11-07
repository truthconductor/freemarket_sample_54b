class AddDealStateToDeals < ActiveRecord::Migration[5.2]
  def change
    add_column :deals, :deal_state_id, :integer, null: false, after: :seller_id, default: 2
  end
end
