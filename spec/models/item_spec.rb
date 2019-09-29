require 'rails_helper'

describe Item do
  describe '#create' do
    # it "is valid with a name, description, amount, item_state_id, deliver_expend_id, deliver_method_id, prefecture_id, deliver_day_id, sales_state_id, category_id, seller_id" do
    #   item = build(:item)
    #   item.valid?
    #   binding.pry
    #   expect(item).to be_valid
    # end
    it "is invalid without a name" do
      item = build(:item, name: "")
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end
    it "is invalid without a description" do
      item = build(:item, description: "")
      item.valid?
      expect(item.errors[:description]).to include("を入力してください")
    end
    it "is invalid without an amount" do
      item = build(:item, amount: "")
      item.valid?
      expect(item.errors[:amount]).to include("は一覧にありません")
    end
    it "is invalid with an amount smaller than 300" do
      item = build(:item, amount: 299)
      item.valid?
      expect(item.errors[:amount]).to include("は一覧にありません")
    end
    it "is invalid with an amount bigger than 9999999" do
      item = build(:item, amount: 10000000)
      item.valid?
      expect(item.errors[:amount]).to include("は一覧にありません")
    end
    it "is invalid without an item_state_id" do
      item = build(:item, item_state_id: nil)
      item.valid?
      expect(item.errors[:item_state_id]).to include("を入力してください")
    end
    it "is invalid without a deliver_expend_id" do
      item = build(:item, deliver_expend_id: nil)
      item.valid?
      expect(item.errors[:deliver_expend_id]).to include("を入力してください")
    end
    it "is invalid without a deliver_method_id" do
      item = build(:item, deliver_method_id: nil)
      item.valid?
      expect(item.errors[:deliver_method_id]).to include("を入力してください")
    end
    it "is invalid without a prefecture_id" do
      item = build(:item, prefecture_id: nil)
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end
    it "is invalid without a deliver_day_id" do
      item = build(:item, deliver_day_id: nil)
      item.valid?
      expect(item.errors[:deliver_day_id]).to include("を入力してください")
    end
    it "is invalid without a sales_state_id" do
      item = build(:item, sales_state_id: nil)
      item.valid?
      expect(item.errors[:sales_state_id]).to include("を入力してください")
    end
    it "is invalid without a category_id" do
      item = build(:item, category_id: nil)
      item.valid?
      expect(item.errors[:category_id]).to include("を入力してください")
    end
  end
end

