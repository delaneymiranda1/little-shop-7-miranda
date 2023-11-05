require 'rails_helper' 

RSpec.describe Merchant, type: :feature do 
  before(:each) do 
    @merchant = Merchant.create!(name: "Spongebob")

    @customer1 = Customer.create!(first_name: "Sandy", last_name: "Cheeks")
    @customer2 = Customer.create!(first_name: "Mermaid", last_name: "Man")
    @customer3 = Customer.create!(first_name: "Sandy", last_name: "Cheeks")

    @item1 = Item.create!(name: "Krabby Patty", description: "Yummy", unit_price: 10, merchant_id: @merchant.id)
    @item2 = Item.create!(name: "Chum Burger", description: "Not As Yummy", unit_price: 9, merchant_id: @merchant.id)
    @item3 = Item.create!(name: "Krabby Patty with Jelly", description: "Damn Good", unit_price: 12, merchant_id: @merchant.id)

    @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id)
    @invoice2 = Invoice.create!(status: 1, customer_id: @customer2.id)
    @invoice3 = Invoice.create!(status: 1, customer_id: @customer3.id)

    @invoice_item1 = InvoiceItem.create!(quantity: 4, unit_price: 40, status: 1, invoice_id: @invoice1.id, item_id: @item1.id)
    @invoice_item2 = InvoiceItem.create!(quantity: 4, unit_price: 36, status: 1, invoice_id: @invoice2.id, item_id: @item2.id)
    @invoice_item3 = InvoiceItem.create!(quantity: 4, unit_price: 48, status: 1, invoice_id: @invoice3.id, item_id: @item3.id)
  end

  describe "visiting the admin/namespace show page" do 
    describe "US1. When I visit my merchant dashboard" do
      it "Then I see the name of my merchant" do
        visit "/merchants/#{@merchant.id}/dashboard"

        expect(page).to have_content("Name: #{@merchant.name}")
      
      end
    end

    describe "US2. Then I see a link to my merchant items index" do
      it "And I see a link to my merchant invoices index" do
        visit "/merchants/#{@merchant.id}/dashboard"

        expect(page).to have_link("Merchant Items Index")
        click_link("Merchant Items Index")
        expect(current_path).to eq("/merchants/#{@merchant.id}/items")

        visit "/merchants/#{@merchant.id}/dashboard"

        expect(page).to have_link("Merchant Invoices Index")
        click_link("Merchant Invoices Index")
        expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")

      end
    end
      xit "next to each Item I see the id of the invoice that ordered my item and each 
      invoice id is a link to my merchant's invoice show page" do
        visit "/merchants/#{@merchant.id}/dashboard"

      end
    end
  
  
  describe "US3. As a merchant, when I visit my merchant dashboard ('/merchants/:merchant_id/dashboard'" do
    it "Then I see the names of my top 5 customers who have completed the largest number of successful transaction with my merchant" do
      visit "/merchants/#{@merchant.id}/dashboard"
      
    end

    it "And next to each customer name I see the number of successful transactions they have conducted with my merchant" do
      visit "/merchants/#{@merchant.id}/dashboard"
      
    end
  end
  describe "US4. I see a section for 'Items Ready to Ship'" do
    it "shows a list of names of all my items that have been ordered and
    have not yet been shipped and the id of the invoice that ordered my item" do
      visit "/merchants/#{@merchant.id}/dashboard"

      within("#items_shipped") do
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@invoice1.id)
        expect(page).to have_link("Invoice ID: #{@invoice1.id}")
      end
    end

    it "the id of the invoice that ordered my item is a link to my merchant's 
    invoice show page" do
      visit "/merchants/#{@merchant.id}/dashboard"

      within("#items_shipped") do  
        click_link("Invoice ID: #{@invoice1.id}")
      end

      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice1.id}")
    end
  end

end