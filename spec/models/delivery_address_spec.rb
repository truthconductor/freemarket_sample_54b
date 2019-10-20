require 'rails_helper'

describe DeliveryAddress do
  describe "#create" do
    # お名前（姓）
    describe "last_name" do
      it "is invalid without a last_name" do
        delivery_address = build(:delivery_address, last_name:"")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:last_name]).to include("を入力してください")
      end
      it "is valid a last_name that has less than　or equal to 35 characters" do
        delivery_address = build(:delivery_address, last_name:"あいうえおかきくけこあいうえおかきくけこあいうえおかきくけこあいうえお")
        delivery_address.user = build(:user)
        expect(delivery_address).to be_valid
      end
      it "is invalid a last_name that has more than 35 characters" do
        delivery_address = build(:delivery_address, last_name:"あいうえおかきくけこあいうえおかきくけこあいうえおかきくけこあいうえおか")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:last_name]).to include("は35文字以内で入力してください")
      end
    end
    # お名前（名）
    describe "first_name" do
      it "is invalid without a first_name" do
        delivery_address = build(:delivery_address, first_name:"")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:first_name]).to include("を入力してください")
      end
      it "is valid a first_name that has less than　or equal to 35 characters" do
        delivery_address = build(:delivery_address, first_name:"あいうえおかきくけこあいうえおかきくけこあいうえおかきくけこあいうえお")
        delivery_address.user = build(:user)
        expect(delivery_address).to be_valid
      end
      it "is invalid a first_name that has more than 35 characters" do
        delivery_address = build(:delivery_address, first_name:"あいうえおかきくけこあいうえおかきくけこあいうえおかきくけこあいうえおか")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:first_name]).to include("は35文字以内で入力してください")
      end
    end
    # お名前カナ（姓）
    describe "last_name_kana" do
      it "is invalid without a last_name_kana" do
        delivery_address = build(:delivery_address, last_name_kana:"")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:last_name_kana]).to include("を入力してください")
      end
      it "is valid a last_name_kana that has less than　or equal to 35 characters" do
        delivery_address = build(:delivery_address, last_name_kana:"アイウエオカキクケコアイウエオカキクケコアイウエオカキクケコアイウエオ")
        delivery_address.user = build(:user)
        expect(delivery_address).to be_valid
      end
      it "is invalid a last_name_kana that has more than 35 characters" do
        delivery_address = build(:delivery_address, last_name_kana:"アイウエオカキクケコアイウエオカキクケコアイウエオカキクケコアイウエオカ")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:last_name_kana]).to include("は35文字以内で入力してください")
      end
      it "is valid a last_name_kana that has katakana characters" do
        delivery_address = build(:delivery_address, last_name_kana:"カタカナ")
        delivery_address.user = build(:user)
        expect(delivery_address).to be_valid
      end
      it "is invalid a last_name_kana that has alphabet characters" do
        delivery_address = build(:delivery_address, last_name_kana:"ABCDE")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:last_name_kana]).to include("を全角カナで入力してください")
      end
      it "is invalid a last_name_kana that has kanji characters" do
        delivery_address = build(:delivery_address, last_name_kana:"亜胃雨絵尾")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:last_name_kana]).to include("を全角カナで入力してください")
      end
      it "is invalid a last_name_kana that has other characters" do
        delivery_address = build(:delivery_address, last_name_kana:"+-*/")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:last_name_kana]).to include("を全角カナで入力してください")
      end
    end
    # お名前カナ（名）
    describe "first_name_kana" do
      it "is invalid without a first_name_kana" do
        delivery_address = build(:delivery_address, first_name_kana:"")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:first_name_kana]).to include("を入力してください")
      end
      it "is valid a first_name_kana that has less than　or equal to 35 characters" do
        delivery_address = build(:delivery_address, first_name_kana:"アイウエオカキクケコアイウエオカキクケコアイウエオカキクケコアイウエオ")
        delivery_address.user = build(:user)
        expect(delivery_address).to be_valid
      end
      it "is invalid a first_name_kana that has more than 35 characters" do
        delivery_address = build(:delivery_address, first_name_kana:"アイウエオカキクケコアイウエオカキクケコアイウエオカキクケコアイウエオカ")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:first_name_kana]).to include("は35文字以内で入力してください")
      end
      it "is valid a first_name_kana that has katakana characters" do
        delivery_address = build(:delivery_address, first_name_kana:"カタカナ")
        delivery_address.user = build(:user)
        expect(delivery_address).to be_valid
      end
      it "is invalid a first_name_kana that has alphabet characters" do
        delivery_address = build(:delivery_address, first_name_kana:"ABCDE")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:first_name_kana]).to include("を全角カナで入力してください")
      end
      it "is invalid a first_name_kana that has kanji characters" do
        delivery_address = build(:delivery_address, first_name_kana:"亜胃雨絵尾")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:first_name_kana]).to include("を全角カナで入力してください")
      end
      it "is invalid a first_name_kana that has other characters" do
        delivery_address = build(:delivery_address, first_name_kana:"+-*/")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:first_name_kana]).to include("を全角カナで入力してください")
      end
    end
    # 郵便番号
    describe "zip_code" do
      it "is invalid without a zip_code" do
        delivery_address = build(:delivery_address, zip_code:"")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:zip_code]).to include("を入力してください")
      end
      it "is invalid a zip_code that has more than 8 characters" do
        delivery_address = build(:delivery_address, zip_code:"1234-5678")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:zip_code]).to include("は8文字以内で入力してください")
      end
      it "is valid a zip_code match to the regular expression" do
        delivery_address = build(:delivery_address, zip_code:"123-5678")
        delivery_address.user = build(:user)
        expect(delivery_address).to be_valid
      end
      it "is invalid a zip_code match to the regular expression" do
        delivery_address = build(:delivery_address, zip_code:"13-32678")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:zip_code]).to include("を正しく入力してください")
      end
    end
    # 都道府県
    describe "prefecture" do
      it "is valid a prefecture is selected" do
        delivery_address = build(:delivery_address, prefecture_id:"20")
        delivery_address.user = build(:user)
        expect(delivery_address).to be_valid
      end
      it "is invalid a prefecture is not selected" do
        delivery_address = build(:delivery_address, prefecture_id:nil)
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:prefecture_id]).to include("を選択してください")
      end
    end
    # 市区町村
    describe "city" do
      it "is invalid without a city" do
        delivery_address = build(:delivery_address, city:"")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:city]).to include("を入力してください")
      end
      it "is valid a city that has less than　or equal to 50 characters" do
        delivery_address = build(:delivery_address, city:Faker::String.random(length: 50))
        delivery_address.user = build(:user)
        expect(delivery_address).to be_valid
      end
      it "is invalid a city that has more than 50 characters" do
        delivery_address = build(:delivery_address, city:Faker::String.random(length: 51))
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:city]).to include("は50文字以内で入力してください")
      end
    end
    # 住所
    describe "address" do
      it "is invalid without a address" do
        delivery_address = build(:delivery_address, address:"")
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:address]).to include("を入力してください")
      end
      it "is valid a address that has less than　or equal to 100 characters" do
        delivery_address = build(:delivery_address, address:Faker::String.random(length: 100))
        delivery_address.user = build(:user)
        expect(delivery_address).to be_valid
      end
      it "is invalid a address that has more than 100 characters" do
        delivery_address = build(:delivery_address, address:Faker::String.random(length: 101))
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:address]).to include("は100文字以内で入力してください")
      end
    end
    # 建物名
    describe "building" do
      it "is valid a building that has less than　or equal to 100 characters" do
        delivery_address = build(:delivery_address, building:Faker::String.random(length: 100))
        delivery_address.user = build(:user)
        expect(delivery_address).to be_valid
      end
      it "is invalid a building that has more than 100 characters" do
        delivery_address = build(:delivery_address, building:Faker::String.random(length: 101))
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:building]).to include("は100文字以内で入力してください")
      end
    end
    # 電話番号
    describe "phone_number" do
      it "is valid a building that has less than　or equal to 35 characters" do
        delivery_address = build(:delivery_address, phone_number:Faker::Number.leading_zero_number(digits: 35))
        delivery_address.user = build(:user)
        expect(delivery_address).to be_valid
      end
      it "is invalid a phone_number that has more than 35 characters" do
        delivery_address = build(:delivery_address, phone_number:Faker::Number.leading_zero_number(digits: 36))
        delivery_address.user = build(:user)
        delivery_address.valid?
        expect(delivery_address.errors[:phone_number]).to include("は35文字以内で入力してください")
      end
    end
  end
end