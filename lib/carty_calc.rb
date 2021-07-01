# frozen_string_literal: true

require 'oj'
require 'price_resolver'

# calculate your cart total
class CartyCalc
  def initialize(cart_file, price_file)
    @cart_json = Oj.load_file(cart_file)
    @price_json = Oj.load_file(price_file)
  end

  def calculate
    calculate_cart_total
  end

  def calculate_cart_total
    subtotals = []

    @cart_json.each do |line_item|
      subtotals << get_line_item_total(line_item)
    end

    subtotals.inject(:+)
  end

  def get_line_item_total(line_item)
    product_type = line_item['product-type']
    options = line_item['options']
    base_price = price_resolver.lookup_base_price(product_type, options)
    artist_markup = line_item['artist-markup']
    quantity = line_item['quantity']

    (base_price + (base_price * artist_markup / 100).round) * quantity
  end

  def price_resolver
    @price_resolver ||= PriceResolver.new(@price_json)
  end
end
