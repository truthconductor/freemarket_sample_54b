class AddBirthdateToPersonals < ActiveRecord::Migration[5.2]
  def change
    add_column :personals, :birthdate, :datetime
  end
end
