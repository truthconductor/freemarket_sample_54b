class Users::CardsController < ApplicationController
  def index
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
  end

  def delete
  end

  private

  def card_params
    params.require(:card).permit(:number, :year, :month, :cvc)
  end
end
