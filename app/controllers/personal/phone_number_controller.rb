class Personal::PhoneNumberController < ApplicationController
  def new
    @phone=Personal.new
  end

  def create
    
    @phone = Personal.new(phone_number_params)
    binding.pry
    @phone.save
    redirect_to 
  end
  

  private

  def phone_number_params
    params.require(:personal).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :zip_code, :prefecture_id, :city, :address, :building, :cellular_phone_number)
  end
end