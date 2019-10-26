class ChangeDatatypeBirthdateOfPersonals < ActiveRecord::Migration[5.2]
  def change
    change_column :personals, :birthdate,:date
  end
end
