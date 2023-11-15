require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
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
    @invoice_item2 = InvoiceItem.create!(quantity: 5, unit_price: 36, status: 1, invoice_id: @invoice2.id, item_id: @item2.id)
    @invoice_item3 = InvoiceItem.create!(quantity: 10, unit_price: 48, status: 1, invoice_id: @invoice3.id, item_id: @item3.id)

    @bulkdiscount1 = @merchant1.bulk_discounts.create!(quantity: 5, discount: 20)
    @bulkdiscount2 = @merchant1.bulk_discounts.create!(quantity: 10, discount: 25)
  end

  describe "#instance_methods" do
    describe "item_name" do
      it "shows the name of the item that is associated with this specific invoice_item" do
        expect(@invoice_item1.item_name).to eq("Krabby Patty")
      end
    end 
    describe "#ii_discount" do
      it 'finds the applicable bulk discount for a specific invoice item' do
        expect(@invoice_item2.ii_discount).to eq(@bulkdiscount1)
        expect(@invoice_item3.ii_discount).to eq(@bulkdiscount2)
      end
    end
  end
end