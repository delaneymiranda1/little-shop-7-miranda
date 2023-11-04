require 'rails_helper' 

RSpec.describe Merchant, type: :feature do 
  before(:each) do 

    
    @merchant = create(:merchant)
    @item1 = @merchant.items.create!(name: "Krabby Patty", description: "yummy", unit_price: "999")

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
  end
  
  describe "US3. As a merchant, when I visit my merchant dashboard ('/merchants/:merchant_id/dashboard'" do
    describe "Then I see the names of my top 5 customers who have completed the largest number of successful transaction with my merchant" do
      it "And next to each customer name I see the number of successful transactions they have conducted with my merchant" do
        @merchant1 = Merchant.create(name: "Spongebob")
        
        @item1 = @merchant1.items.create(name: "Krabby Patty", description: "yummy", unit_price: "999")
        @item2 = @merchant1.items.create(name: "Krabby Patty", description: "yummy", unit_price: "999")
    
        @customer1 = Customer.create(first_name: "Patrick", last_name: "Star")
        @customer2 = Customer.create(first_name: "Sandy", last_name: "Cheeks")
        @customer3 = Customer.create(first_name: "King", last_name: "Neptune")
        @customer4 = Customer.create(first_name: "Eugene", last_name: "Krabs")
        @customer5 = Customer.create(first_name: "Sheldon", last_name: "Plankton")
        @customer6 = Customer.create(first_name: "Poppy", last_name: "Puff")
    
        @invoice1 = Invoice.create(status: 1, customer_id: @customer1.id)
        @invoice2 = Invoice.create(status: 1, customer_id: @customer2.id)
        @invoice3 = Invoice.create(status: 1, customer_id: @customer3.id)
        @invoice4 = Invoice.create(status: 1, customer_id: @customer4.id)
        @invoice5 = Invoice.create(status: 1, customer_id: @customer5.id)
        @invoice6 = Invoice.create(status: 1, customer_id: @customer6.id)
    
        @invoiceitem1 = InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item1.id)
        @invoiceitem2 = InvoiceItem.create(invoice_id: @invoice2.id, item_id: @item1.id)
        @invoiceitem3 = InvoiceItem.create(invoice_id: @invoice3.id, item_id: @item1.id)
        @invoiceitem4 = InvoiceItem.create(invoice_id: @invoice4.id, item_id: @item2.id)
        @invoiceitem5 = InvoiceItem.create(invoice_id: @invoice5.id, item_id: @item1.id)
        @invoiceitem6 = InvoiceItem.create(invoice_id: @invoice6.id, item_id: @item1.id)
  
          Transaction.create(invoice_id: @invoice1.id, result: 0)
          Transaction.create(invoice_id: @invoice2.id, result: 0)
          Transaction.create(invoice_id: @invoice2.id, result: 0)
        3.times do
          Transaction.create(invoice_id: @invoice3.id, result: 1)
        end
        4.times do
          Transaction.create(invoice_id: @invoice4.id, result: 0)
        end
        5.times do
          Transaction.create(invoice_id: @invoice5.id, result: 0)
        end
        5.times do
          Transaction.create(invoice_id: @invoice5.id, result: 1)
        end
        6.times do
          Transaction.create(invoice_id: @invoice6.id, result: 0)
        end
  
        @merchant2 = Merchant.create(name: "Squidward")
        @item3 = @merchant2.items.create(name: "Krabby Patty", description: "yummy", unit_price: "999")
        @customer7 = Customer.create(first_name: "Larry", last_name: "Lobster")
        @invoice7 = Invoice.create(status: 1, customer_id: @customer7.id)
        @invoiceitem7 = InvoiceItem.create(invoice_id: @invoice7.id, item_id: @item3.id)
        7.times do
          Transaction.create(invoice_id: @invoice7.id, result: 0)
        end
  
        visit "/merchants/#{@merchant1.id}/dashboard"
  
        expect(page).to have_content("Top 5 Customers, # of Transactions")
        expect("Poppy Puff: 6").to appear_before("Sheldon Plankton: 5")
        expect("Sheldon Plankton: 5").to appear_before("Eugene Krabs: 4")
        expect("Eugene Krabs: 4").to appear_before("Sandy Cheeks: 2")
        expect("Sandy Cheeks: 2").to appear_before("Patrick Star: 1")
      end      
    end
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