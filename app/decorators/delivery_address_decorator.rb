class DeliveryAddressDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  # 発送先氏名を連結して表示用に作成
  def full_name
    "#{last_name} #{first_name}"
  end

  # 発送先住所を連結して表示用に作成
  def full_address
    if(building)
      "#{prefecture.name} #{city}#{address} #{building}"
    else
      "#{prefecture.name} #{city}#{address}"
    end
  end
end
