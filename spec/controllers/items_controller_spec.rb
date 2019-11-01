require 'rails_helper'

describe ItemsController do
  # showアクションのテスト
  describe 'GET #show' do
    # 表示テスト用のitem(商品)を作成
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
      @item.seller = build(:user, id: 1, confirmed_at:Date.today)
      @item.save
    end
    # ページ遷移テスト
    it "renders the :show template" do
      get :show, params: { id: 1 }
      expect(response).to render_template :show
    end
    # showアクションで取得した@itemが意図した商品情報と一致するテスト
    it "assigns the requested item to @item" do
      get :show, params: { id: @item }
      expect(assigns(:item)).to eq @item
    end
  end

  # destroyアクションのテスト
  describe 'delete #destroy' do

    let!(:seller) { create(:user, id: 1, confirmed_at:Date.today) }
    let!(:not_seller) { create(:user, id: 2, confirmed_at:Date.today) }
    # 販売中商品を定義
    let!(:on_sale_item) {
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
    # 完売商品を定義
    let!(:sold_out_item) {
      item = build(:item,
        id: 2,
        category_id: 3,
        item_state_id: 1,
        deliver_expend_id: 2,
        deliver_method_id: 1,
        deliver_day_id: 2,
        sales_state_id: 3)
      item.item_images << build(:item_image)
      item.seller = seller
      item.save
      return item
    }

    context 'item on sale and item seller is current login user' do
      before do
        include Devise::TestHelpers
        sign_in(seller)
      end
      #出品者が出品中の商品を削除することをテスト
      it "delete sale item" do
        expect{
          delete :destroy, params: { id: on_sale_item }
        }.to change(Item,:count).by(-1)
      end

      # 商品削除後マイページへ遷移することをテスト
      it "redirect to mypage" do
        delete :destroy, params: { id: on_sale_item }
        expect(response).to redirect_to mypage_path
      end
    end

    context 'item is sold out and item seller is current login user' do
      before do
        include Devise::TestHelpers
        sign_in(seller)
      end
      # 出品者が完売した商品を削除できないことをテスト
      it "can't delete sold out item" do
        expect{
          delete :destroy, params: { id: sold_out_item }
        }.to change(Item,:count).by(0)
      end
    end

    context 'seller is not current login user' do
      before do
        include Devise::TestHelpers
        sign_in(not_seller)
      end
      # 出品者以外が商品を削除できないことをテスト
      it "can't delete item call other user request" do
        expect{
          delete :destroy, params: { id: sold_out_item }
        }.to change(Item,:count).by(0)
      end
    end
  end
end