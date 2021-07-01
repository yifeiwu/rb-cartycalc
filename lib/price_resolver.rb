# frozen_string_literal: true

# given a option set, return the price
class PriceResolver
  def initialize(price_json)
    @price_json = price_json
    @price_lookup = Hash.new { |h, k| h[k] = h.class.new(&h.default_proc) } # allow nested assignments
    @price_option_identifier = {}
    generate_price_lookup
  end

  def lookup_base_price(product_type, options)
    case options.keys.length
    when 0
      @price_lookup[product_type.to_s]
    when 1
      @price_lookup[product_type.to_s][options.values[0].to_s]
    else
      option_keys = @price_option_identifier[product_type.to_s]

      option_values_key = option_keys.inject('') { |memo, option| memo + options[option.to_s] }
      @price_lookup[product_type.to_s][option_values_key.to_s]
    end
  end

  def generate_price_lookup
    @price_json.each do |product|
      product_type = product['product-type']
      base_price = product['base-price']
      option_keys = product['options'].keys.sort # make the ordering deterministic
      set_price_option_identifier(product_type, option_keys)

      case option_keys.length

      when 0
        @price_lookup[product_type.to_s] = base_price

      when 1
        option_value_keys = product['options'].values[0]

        option_value_keys.each do |key|
          @price_lookup[product_type.to_s][key.to_s] = base_price
        end
      else
        generate_keys_for_2n_options(product, option_keys).each do |key|
          @price_lookup[product_type.to_s][key.to_s] = base_price
        end
      end
    end
  end

  def generate_keys_for_2n_options(product, option_keys)
    option_identifier = product['options'][(option_keys[0]).to_s]

    option_keys[1..].each do |option|
      option_values = product['options'][option.to_s]
      # denormalize
      option_identifier = option_identifier.product(option_values)
    end

    option_identifier.map { |identifier| identifier.join('') }
  end

  def set_price_option_identifier(product_type, option_keys)
    return if @price_option_identifier.key?([product_type.to_s])

    @price_option_identifier[product_type.to_s] = option_keys
  end
end
