class Payment < ApplicationRecord
  #Validation
  validates :amount, :point, presence: true
  #Association
  belongs_to :deal
end
