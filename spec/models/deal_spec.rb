require 'rails_helper'

describe Deal do
  describe '#create' do
    # 必要なデータをletで用意
    let(:seller) { create(:user, id: 1) }
    let(:buyer) { create(:user, id: 2) }
    let(:item) {
      item = build(:item,
            id: 1,
            category_id: 3,
            item_state_id: 1,
            deliver_expend_id: 2,
            deliver_method_id: 1,
            deliver_day_id: 2,
            sales_state_id: 1)
      item.item_images << build(:item_image)
      item.seller = seller
      item.save
      return item
    }
    let(:payment) { build(:payment) }
    let(:deal) { build(:deal, buyer:buyer, seller:seller, item:item, payment:payment) }

    # バリデーションをテストする
    subject { deal.valid? }

    context 'member is not nil' do
      it "is valid" do
        is_expected.to eq true
      end
    end

    context 'item is nil' do
      let(:item) { nil }
      it "is invalid without a item" do
        is_expected.to eq false
        expect(deal.errors[:item]).to include("を入力してください")
      end
    end

    context 'payment is nil' do
      let(:payment) { nil }
      it "is invalid without a payment" do
        is_expected.to eq false
        expect(deal.errors[:payment]).to include("を入力してください")
      end
    end

    context 'buyer is nil' do
      let(:buyer) { nil }
      it "is invalid without a buyer" do
        is_expected.to eq false
        expect(deal.errors[:buyer]).to include("を入力してください")
      end
    end

    context 'seller is nil' do
      let(:seller) { nil }
      it "is invalid without a seller" do
        is_expected.to eq false
        expect(deal.errors[:seller]).to include("を入力してください")
      end
    end
  end
end