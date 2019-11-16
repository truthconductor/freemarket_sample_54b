class Api::BrandsController < ApplicationController
  def search
    @brands = Brand.where("name LIKE ?", "%#{params[:keyword]}%")
  end
end