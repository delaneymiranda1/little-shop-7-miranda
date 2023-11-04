require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  before(:each) do 
    @merchant1 = Merchant.create!(name: "Spongebob")

    @customer1 = Customer.create!(first_name: "Sandy", last_name: "Cheeks")
    @customer2 = Customer.create!(first_name: "Mermaid", last_name: "Man")
    @customer3 = Customer.create!(first_name: "Sandy", last_name: "Cheeks")

    @item1 = Item.create!(name: "Krabby Patty", description: "Yummy", unit_price: 10, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "Chum Burger", description: "Not As Yummy", unit_price: 9, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: "Krabby Patty with Jelly", description: "Damn Good", unit_price: 12, merchant_id: @merchant1.id)

    @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id)
    @invoice2 = Invoice.create!(status: 1, customer_id: @customer2.id)
    @invoice3 = Invoice.create!(status: 1, customer_id: @customer3.id)

    @invoice_item1 = InvoiceItem.create!(quantity: 4, unit_price: 40, status: 1, invoice_id: @invoice1.id, item_id: @item1.id)
    @invoice_item2 = InvoiceItem.create!(quantity: 4, unit_price: 36, status: 1, invoice_id: @invoice2.id, item_id: @item2.id)
    @invoice_item3 = InvoiceItem.create!(quantity: 4, unit_price: 48, status: 1, invoice_id: @invoice3.id, item_id: @item3.id)
  end

  describe "#instance_methods" do
    describe "items_to_ship" do
      it "shows all invoice_items that have a status of 'pending' that are associated with 
      this specific merchant" do
        expect(@merchant1.items_to_ship).to eq([@invoice_item1, @invoice_item2, @invoice_item3])
      end
    end  
  end
end