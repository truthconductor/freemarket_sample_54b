class ItemDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  # 商品金額を ¥(円マーク)3桁区切り整数 で表示する
  def amount_text
    "¥#{amount.to_s(:delimited, delimiter: ',')}"
  end

  # 発送条件に応じて「着払い」か「送料込」の文字にして返す
  def cash_on_delevery_text
    if deliver_method.cash_on_delivery
      "着払い"
    else
      "送料込み"
    end
  end

end
