# frozen_string_literal: true

require 'price_resolver'
require 'oj'
describe 'PriceResolver' do
  let(:price_json) { Oj.load_file('test-data/base-prices.json') }

  let(:subject) { PriceResolver.new(price_json) }

  describe 'it looks up the base prices' do
    it 'looks up the correct value for items without options' do
      price = subject.lookup_base_price('leggings', {})
      expect(price).to eq(5000)
    end

    it 'looks up the correct value for items with one option' do
      price = subject.lookup_base_price('sticker', { 'size' => 'medium' })
      expect(price).to eq(583)
    end

    it 'looks up the correct value for items with two or more options' do
      price = subject.lookup_base_price('hoodie', { 'size' => 'large', 'colour' => 'dark' })
      expect(price).to eq(4212)
    end
  end
end
