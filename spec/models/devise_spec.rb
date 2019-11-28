require 'rails_helper'

describe DeliveryAddress do
  describe "#create" do
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
    end
    it "苗字(カナ)は英数字を弾く" do
      personal = build(:personal,first_name_kana: "a")
      personal.valid?
      expect(personal.errors[:first_name_kana]).to include("はひらがなかカタカナで入力してください")
    end
    it "名前（カナ）のバリデーション" do
      personal = build(:personal,last_name_kana: "")
      personal.valid?
      expect(personal.errors[:last_name_kana]).to include("を入力してください")
    end
    it "名前(カナ)は英数字を弾く" do
      personal = build(:personal,last_name_kana: "a")
      personal.valid?
      expect(personal.errors[:last_name_kana]).to include("はひらがなかカタカナで入力してください")
    end
    it "誕生日のバリデーション" do
      personal = build(:personal,birthdate: "")
      personal.valid?
      expect(personal.errors[:birthdate]).to include("を入力してください")
    end

    it "電話番号のバリデーション" do
      personal=build(:personal,cellular_phone_number: "")
      personal.valid?
      expect(personal.errors[:cellular_phone_number]).to include("を入力してください")
    end
  end
end