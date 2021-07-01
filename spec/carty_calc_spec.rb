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
      it 'calculates the total of a dummy resolver' do
        # 2x 100c items with 30% markup
        PriceResolver.any_instance.stub(:lookup_base_price).and_return(100)
        expect(subject.calculate).to eq(260)
      end
    end

    describe 'using test carts' do
      test_array = { 'test-data/cart-9500.json' => 9500, 'test-data/cart-4560.json' => 4560,
                     'test-data/cart-9363.json' => 9363 }

      test_array.each do |cart, total|
        it 'returns the correct total' do
          subject = CartyCalc.new(cart, price_json)
          expect(subject.calculate).to eq(total)
        end
      end
    end
  end
end
