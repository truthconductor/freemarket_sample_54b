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
      @item.seller = build(:user, id: 1)
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
end