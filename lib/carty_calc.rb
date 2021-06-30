# frozen_string_literal: true

require 'oj'

# calculate your cart total
class CartyCalc
  def initialize(cart_file, price_file)
    @cart_json = Oj.load_file(cart_file)
    @price_json = Oj.load_file(price_file)
  end

  def calculate
    # todo
  end
end
