require 'rails_helper' 

RSpec.describe Merchant, type: :feature do 
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
        expect(current_path).to eq("/merchants/#{@merchant.first.id}/invoices")

      end
    end
      xit "next to each Item I see the id of the invoice that ordered my item and each 
      invoice id is a link to my merchant's invoice show page" do
        visit "/merchants/#{@merchant1.id}/dashboard"

      end
    end
  
  
  describe "US3. As a merchant, when I visit my merchant dashboard ('/merchants/:merchant_id/dashboard'" do
    it "Then I see the names of my top 5 customers who have completed the largest number of successful transaction with my merchant" do
      visit "/merchants/#{@merchant.first.id}/dashboard"
      
    end

    it "And next to each customer name I see the number of successful transactions they have conducted with my merchant" do
      visit "/merchants/#{@merchant.first.id}/dashboard"
      
    end
  end



# merchant_list = create_list(:merchant , 10)
# item_list = []
# 30.times do
#   item_list << create(:item, merchant: merchant_list.sample)
# end
# customer_list = create_list(:customer, 10)
# invoice_list = []
# 10.times do
#   invoice_list << create(:invoice, customer: customer_list.sample)
# end
# invoice_item_list = []
# 10.times do
#   invoice_item_list << create(:invoice_item, invoice: invoice_list.sample, item: item_list.sample)
# end
# transaction_list = []
# 100.times do
#   transaction_list << create(:transaction, invoice: invoice_list.sample)
# end