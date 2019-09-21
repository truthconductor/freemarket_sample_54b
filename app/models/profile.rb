class Profile < ApplicationRecord
  #Validation
  validates :nickname, {maximum: 20}
  validates :nickname, presence: true
  validates :introduction, {maximum: 1000}
  #Association
  belongs_to :user
end
