class Profile < ApplicationRecord
  #Validation
  validates :nickname, presence: true
  validates :nickname, length: {maximum: 20}
  validates :introduction, length: {maximum: 1000}
  #Association
  belongs_to :user
end
