class AddFirstLetterToBrand < ActiveRecord::Migration[5.2]
  def change
    add_column :brands, :first_letter, :string, null:false, after: :name
  end
end
