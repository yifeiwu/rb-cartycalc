# frozen_string_literal: true

require 'carty_calc'

describe 'CartyCalc' do
  let(:price_json) { 'test-data/base-prices.json' }
  let(:cart_json) { 'test-data/cart-11356.json' }

  let(:subject) { CartyCalc.new(cart_json, price_json) }
  describe 'it reads and parses the inputs' do
    # skip for this assignment
  end

  describe 'it presents the correct total' do
    describe '#calculate' do
      it 'calculates the total of a given cart' do
        # 2x 100c items with 30% markup
        PriceResolver.any_instance.stub(:lookup_base_price).and_return(100)
        expect(subject.calculate).to eq(260)
      end
    end
  end
end
