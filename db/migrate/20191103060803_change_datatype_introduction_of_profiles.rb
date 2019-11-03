class ChangeDatatypeIntroductionOfProfiles < ActiveRecord::Migration[5.2]
  def change
    change_column :profiles, :introduction, :text
  end
end
