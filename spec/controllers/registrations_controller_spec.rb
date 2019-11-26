require 'rails_helper'

describe Users::RegistrationsController do
  include Devise::Test::ControllerHelpers
  describe  "pesonal_name" do
    describe "get #personal_name" do
      before :each do
        request.env['devise.mapping'] = Devise.mappings[:user]
      end
      it "personal_nameへのアクセスを確認" do
        get 'personal_name'
        expect(response).to be_successful
      end
      it "電話番号ページのレスポンス" do
        get 'phone_number'
        expect(response).to be_successful
      end
      it "メールのバリデーション" do
        user = build(:user, email: "")
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end
      it "パスワードのバリデーション" do
        user = build(:user, password: "")
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end
      it "確認用パスワードのバリデーション" do
        user = build(:user, password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end
      it "ニックネームのバリデーション" do
        profile = build(:profile,nickname: "")
        profile.valid?
        expect(profile.errors[:nickname]).to include("を入力してください")
      end
      it "苗字のバリデーション" do
        personal = build(:personal,last_name: "")
        personal.valid?
        expect(personal.errors[:last_name]).to include("を入力してください")
      end
      it "名前のバリデーション" do
        personal = build(:personal,first_name: "")
        personal.valid?
        expect(personal.errors[:first_name]).to include("を入力してください")
      end
      it "苗字（カナ）のバリデーション" do
        personal = build(:personal,first_name_kana: "")
        personal.valid?
        expect(personal.errors[:first_name_kana]).to include("を入力してください")
        expect(personal.errors[:first_name_kana]).to include("はひらがなかカタカナで入力してください")
      end
      it "誕生日のバリデーション" do
        personal = build(:personal,birthdate: "")
        personal.valid?
        expect(personal.errors[:birthdate]).to include("を入力してください")
      end
    end
  describe "phone_number" do

  end
    context "有効なデータの場合" do 
      before :each do
        request.env['devise.mapping'] = Devise.mappings[:user]
      end
      
        it "電話番号確認ページにリダイレクトすること" do
          
          expect(response).to redirect_to phone_number_path
        end
    end      
  end

  describe "create" do
    context "create_success" do
      before do


      it "redirect_to top_page" do
        expect(response).to redirect_to root_path
      end 
  end
    
    context "create_failuer" do
     
    end
    end
  end
end
  