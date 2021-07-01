# frozen_string_literal: true

# price_menu and lookup
class PriceResolver
  def initialize(price_json)
    price_json
  end

  def lookup_base_price(_product_type, _options)
    # it's a dollar store!
    100
  end
end
