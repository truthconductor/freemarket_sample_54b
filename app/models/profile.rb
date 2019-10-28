class Profile < ApplicationRecord
  #Validation
  validates :nickname, length: {maximum: 20}
  validates :nickname, presence: true
  validates :introduction, length: {maximum: 1000}
  #Association
  belongs_to :user

  
end
