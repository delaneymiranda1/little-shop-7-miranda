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

  describe '#active?' do
    it 'returns true if the item is active' do
      item = create(:item, active: true)
      expect(item.active?).to be true
    end

    it 'returns false if the item is not active' do
      item = create(:item, active: false)
      expect(item.active?).to be false
    end
  end

  describe "#best_day" do
    before :each do
      @merchant = Merchant.create(name: 'Merchant 1', enabled: true)
      @item = @merchant.items.create(name: 'Item 1', description: 'Description 1', unit_price: 100, active: true)
      @customer = Customer.create(first_name: "Patrick", last_name: "Star")
      @invoice1 = Invoice.create(status: 2, customer_id: @customer.id)
      @invoice1.update(created_at: "03 Nov 2023 20:25:45 UTC +00:00")
      @invoice2 = Invoice.create(status: 2, customer_id: @customer.id)
      @invoice2.update(created_at: "03 Nov 2023 02:26:45 UTC +00:00")
      @invoice3 = Invoice.create(status: 2, customer_id: @customer.id)
      @invoice3.update(created_at: "04 Nov 2023 20:26:45 UTC +00:00")
      @invoice4 = Invoice.create(status: 2, customer_id: @customer.id)
      @invoice4.update(created_at: "05 Nov 2023 10:26:45 UTC +00:00")
      @invoice5 = Invoice.create(status: 2, customer_id: @customer.id)
      @invoice5.update(created_at: "05 Nov 2023 09:26:45 UTC +00:00")
      @invoice6 = Invoice.create(status: 2, customer_id: @customer.id)
      @invoice6.update(created_at: "05 Nov 2023 14:26:45 UTC +00:00")
      Transaction.create(invoice_id: @invoice1.id, result: 1)
      Transaction.create(invoice_id: @invoice1.id, result: 0)
      Transaction.create(invoice_id: @invoice2.id, result: 0)
      3.times do
        Transaction.create(invoice_id: @invoice3.id, result: 1)
      end
      Transaction.create(invoice_id: @invoice4.id, result: 0)
      Transaction.create(invoice_id: @invoice5.id, result: 0)
      Transaction.create(invoice_id: @invoice6.id, result: 0)
      InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item.id, status: 1, quantity: 15, unit_price: 100)
      InvoiceItem.create(invoice_id: @invoice2.id, item_id: @item.id, status: 1, quantity: 10, unit_price: 100)
      InvoiceItem.create(invoice_id: @invoice3.id, item_id: @item.id, status: 1, quantity: 30, unit_price: 100)
      InvoiceItem.create(invoice_id: @invoice4.id, item_id: @item.id, status: 1, quantity: 4, unit_price: 100)
      InvoiceItem.create(invoice_id: @invoice5.id, item_id: @item.id, status: 1, quantity: 5, unit_price: 100)
      InvoiceItem.create(invoice_id: @invoice6.id, item_id: @item.id, status: 1, quantity: 6, unit_price: 100)
    end
    it "returns the day with the most sales of an object" do
      expect(@item.best_day).to eq("03 Nov 2023")
      Transaction.create(invoice_id: @invoice3.id, result: 0)
      expect(@item.best_day).to eq("04 Nov 2023")
    end
    
    it "if two days are tied, it returns the most recent day" do
      @invoice7 = Invoice.create(status: 2, customer_id: @customer.id)
      @invoice7.update(created_at: "05 Nov 2023 14:26:45 UTC +00:00")
      Transaction.create(invoice_id: @invoice7.id, result: 0)
      InvoiceItem.create(invoice_id: @invoice7.id, item_id: @item.id, status: 1, quantity: 10, unit_price: 100)
      expect(@item.best_day).to eq("05 Nov 2023")
    end
  end
end