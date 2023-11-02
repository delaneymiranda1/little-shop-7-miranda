require 'rails_helper' 

RSpec.describe Merchant, type: :feature do 
  before(:each) do 

    @merchant_1 = Merchant.create!(name: "Spongebob")

    @customer_1 = Customer.create!(first_name: "Sandy", last_name: "Cheeks")
    @customer_2 = Customer.create!(first_name: "Mermaid", last_name: "Man")
    @customer_3 = Customer.create!(first_name: "Sandy", last_name: "Cheeks")

    @item_1 = Item.create!(name: "Krabby Patty", description: "Yummy", unit_price: 10, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Chum Burger", description: "Not As Yummy", unit_price: 9, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: "Krabby Patty with Jelly", description: "Damn Good", unit_price: 12, merchant_id: @merchant_1.id)

    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 1, customer_id: @customer_2.id)
    @invoice_3 = Invoice.create!(status: 1, customer_id: @customer_3.id)

    @invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 40, status: 1, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 4, unit_price: 36, status: 1, invoice_id: @invoice_2.id, item_id: @item_2.id)
    @invoice_item_3 = InvoiceItem.create!(quantity: 4, unit_price: 48, status: 1, invoice_id: @invoice_3.id, item_id: @item_3.id)
    # @merchant_1 = create(:merchant)

    # @customer_1 = create(:customer)
    # @customer_2 = create(:customer)
    # @customer_3 = create(:customer)
    # @customer_4 = create(:customer)
    # @customer_5 = create(:customer)

    # @item_1 = create(:item, merchant_id: @merchant_1.id)
    # @item_2 = create(:item, merchant_id: @merchant_1.id)
    # @item_3 = create(:item, merchant_id: @merchant_1.id)
    # @item_4 = create(:item, merchant_id: @merchant_1.id)
    # @item_5 = create(:item, merchant_id: @merchant_1.id)

    # @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    # @invoice_2 = create(:invoice, customer_id: @customer_2.id)
    # @invoice_3 = create(:invoice, customer_id: @customer_3.id)
    # @invoice_4 = create(:invoice, customer_id: @customer_4.id)
    # @invoice_5 = create(:invoice, customer_id: @customer_5.id)

    # @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)
    # @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id)
    # @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id)
    # @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id)
    # @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id)

  end

  describe "visiting the admin/namespace show page" do 
    describe "US1. When I visit my merchant dashboard" do
      it "Then I see the name of my merchant" do
        visit "/merchants/#{@merchant_1.id}/dashboard"

        expect(page).to have_content("Name: #{@merchant_1.name}")
      end
    end

    describe "US2. Then I see a link to my merchant items index" do
      it "And I see a link to my merchant invoices index" do
        visit "/merchants/#{@merchant_1.id}/dashboard"

        expect(page).to have_link("Merchant Items Index")
        click_link("Merchant Items Index")
        expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")

        visit "/merchants/#{@merchant_1.id}/dashboard"

        expect(page).to have_link("Merchant Invoices Index")
        click_link("Merchant Invoices Index")
        expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
      end
    end
    # 4. Merchant Dashboard Items Ready to Ship

    # As a merchant
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see a section for "Items Ready to Ship"
    # In that section I see a list of the names of all of my items that
    # have been ordered and have not yet been shipped,
    # And next to each Item I see the id of the invoice that ordered my item
    # And each invoice id is a link to my merchant's invoice show page

    #enum for invoice needs to be "in progress" 
    describe "US4. I see a section for 'Items Ready to Ship'" do
      it " shows a list of names of all my items that have been ordered and
      have not yet been shipped" do
        visit "/merchants/#{@merchant_1.id}/dashboard"

        within("#items_shipped") do
          expect(page).to have_content(@item.name)
        end
      end
# built out the section and named a method, but need to work on how to reach it 
      it "next to each Item I see the id of the invoice that ordered my item and each 
      invoice id is a link to my merchant's invoice show page" do
        visit "/merchants/#{@merchant_1.id}/dashboard"

      end
    end
  end
end