require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end
  require 'rails_helper'

  describe '#unit_price_to_dollars' do
    let(:item) { create(:item, unit_price: 1000) } # create an item with a unit_price of 1000 cents ($10.00)

    it 'returns the price in dollars' do
      expect(item.unit_price_to_dollars).to eq('$10.00')
    end

    context 'when the price is less than $1.00' do
      let(:item) { create(:item, unit_price: 50) } # create an item with a unit_price of 50 cents ($0.50)

      it 'returns the price in dollars with a leading zero' do
        expect(item.unit_price_to_dollars).to eq('$0.50')
      end
    end
  end
end