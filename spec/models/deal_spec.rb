require 'rails_helper'

describe Deal do
  describe '#create' do
    # 購入テスト用のitem(商品)を作成
    before do
      @item = build(:item,
                    id: 1,
                    category_id: 3,
                    item_state_id: 1,
                    deliver_expend_id: 2,
                    deliver_method_id: 1,
                    deliver_day_id: 2,
                    sales_state_id: 1)
      @item.item_images << build(:item_image)
      # 販売者を作成
      @item.seller = build(:user, id: 1)
      @item.save
      # 購入者を作成
      ＠buyer = build(:user, id: 2)
      ＠buyer.save
    end

    it "is invalid" do
      deal = build(:deal, buyer_id:2, seller_id:1)
      deal.payment = build(:payment)
      deal.item = build(:item)
      expect(deal).to be_valid
    end

    it "is invalid without a item" do
      deal = build(:deal, buyer_id:2, seller_id:1)
      deal.payment = build(:payment)
      deal.valid?
      expect(deal.errors[:item]).to include("を入力してください")
    end

    it "is invalid without a payment" do
      deal = build(:deal, buyer_id:2, seller_id:1)
      deal.item = build(:item)
      deal.valid?
      expect(deal.errors[:payment]).to include("を入力してください")
    end

    it "is invalid without a buyer" do
      deal = build(:deal, buyer_id:nil, seller_id:1)
      deal.item = build(:item)
      deal.valid?
      expect(deal.errors[:buyer]).to include("を入力してください")
    end
    
    it "is invalid without a seller" do
      deal = build(:deal, buyer_id:2, seller_id:nil)
      deal.item = build(:item)
      deal.valid?
      expect(deal.errors[:seller]).to include("を入力してください")
    end
  end
end