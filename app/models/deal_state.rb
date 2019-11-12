class DealState < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
      {id: 1, state: "支払い待ち"},
      {id: 2, state: "発送待ち"},
      {id: 3, state: '配送中'},
      {id: 4, state: '受取済み'},
      {id: 5, state: '取引完了'}
  ]
  has_many :deals
end