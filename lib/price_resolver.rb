# frozen_string_literal: true

# given a option set, return the price
class PriceResolver
  def initialize(price_json)
    @price_json = price_json
    generate_price_lookup
  end

  def lookup_base_price(product_type, options)
    case options.keys.length
    when 0
      base_price = @price_lookup[product_type.to_s]
    when 1
      base_price = @price_lookup[product_type.to_s][options.values[0].to_s]
    else
      option_keys = @price_option_id[product_type.to_s]

      option_choice_key = option_keys.inject('') { |memo, option| memo + options[option.to_s] }
      base_price = @price_lookup[product_type.to_s][option_choice_key.to_s]
    end

    base_price
  end

  def generate_price_lookup
    @price_lookup = Hash.new { |h, k| h[k] = h.class.new(&h.default_proc) } # allow nested assignments
    @price_option_id = {}

    @price_json.each do |product|
      product_type = product['product-type']
      base_price = product['base-price']
      option_keys = product['options'].keys.sort # make the ordering deterministic
      @price_option_id[product_type.to_s] = option_keys unless @price_option_id.key?([product_type.to_s])

      case option_keys.length

      when 0
        @price_lookup[product_type.to_s] = base_price
        next

      when 1
        option_key = option_keys[0]
        option_choice_keys = product['options'][option_key.to_s]

        option_choice_keys.each do |key|
          @price_lookup[product_type.to_s][key.to_s] = base_price
        end
      else
        option_values = option_keys.inject([]) { |memo, option| memo << product['options'][option.to_s] }

        base = option_values[0]

        option_values[1..].each do |option|
          base = base.product(option)
        end

        option_choice_keys = base.map { |x| x.join('') }

        option_choice_keys.each do |key|
          @price_lookup[product_type.to_s][key.to_s] = base_price
        end
      end
    end
  end
end
