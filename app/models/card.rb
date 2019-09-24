class Card
  include ActiveModel::Model
  attr_accessor :number, :month, :year, :cvc, :payjpToken

  #月選択
  @@month_select = []
  for month in 1..12 do
    @@month_select << [format('%02d', month), month]
  end
  def month_select
    @@month_select
  end

  #月選択
  @@year_select = []
  yearStart = Date.today.strftime("%y").to_i
  for year in Range.new(yearStart, yearStart+10) do
    @@year_select << [format('%02d', year), year]
  end
  def year_select
    @@year_select
  end

  #Validation
  validates :number, presence: true
  validates :month, presence: true
  validates :year, presence: true
  validates :cvc, presence: true

  def initialize(attributes={})
    @number = attributes[:number]
    @month = attributes[:month] || 1
    @year = attributes[:year] || Date.today.strftime("%y").to_i
    @code = attributes[:cvc]
    @payjpToken = attributes[:payjpToken]
  end

end
