require 'rails_helper'

RSpec.describe 'Merchant items index page' do
  before(:each) do
    @merchant1 = Merchant.create(name: 'Merchant 1', enabled: true)
    @merchant2 = Merchant.create(name: 'Merchant 2', enabled: true)

    @item1 = @merchant1.items.create(name: 'Item 1', description: 'Description 1', unit_price: 100, active: true)
    @item2 = @merchant1.items.create(name: 'Item 2', description: 'Description 2', unit_price: 200, active: true)
    @item3 = @merchant2.items.create(name: 'Item 3', description: 'Description 3', unit_price: 300, active: true)
  end

  describe 'when a merchant visits their items index page' do
    it 'displays a list of the names of all of their items and does not display items for any other merchant' do
      visit "/merchants/#{@merchant1.id}/items"

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to_not have_content(@item3.name)
    end
    
    it 'displays a button to disable or enable each item' do
      visit "/merchants/#{@merchant1.id}/items"

      expect(page).to have_button('Disable', count: 2)
      expect(page).to_not have_button('Enable')
    end

    it 'changes the item status when the disable/enable button is clicked' do
      visit "/merchants/#{@merchant1.id}/items"

      click_button('Disable', match: :first)

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
      expect(page).to have_content('Status: inactive')
      expect(page).to have_button('Enable', count: 1)
      expect(page).to have_button('Disable', count: 1)

      click_button('Enable', match: :first)

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
      expect(page).to have_content('Status: active')
      expect(page).to have_button('Disable', count: 2)
      expect(page).to_not have_button('Enable')
    end

    describe 'I see the names of the top 5 most popular items ranked by total revenue generated' do
      before :each do
        @item3 = @merchant1.items.create(name: 'Item 3', description: 'Description 1', unit_price: 300, active: true)
        @item4 = @merchant1.items.create(name: 'Item 4', description: 'Description 1', unit_price: 100, active: true)
        @item5 = @merchant1.items.create(name: 'Item 5', description: 'Description 2', unit_price: 200, active: true)
        @item6 = @merchant1.items.create(name: 'Item 6', description: 'Description 3', unit_price: 300, active: true)
        @item7 = @merchant1.items.create(name: 'Item 7', description: 'Description 3', unit_price: 300, active: true)
        @item8 = @merchant2.items.create(name: 'Item 8', description: 'Description 3', unit_price: 10000, active: true)

        @customer = Customer.create(first_name: "Patrick", last_name: "Star")
        @invoice1 = Invoice.create(status: 2, customer_id: @customer.id)
        @invoice2 = Invoice.create(status: 2, customer_id: @customer.id)
        @invoice3 = Invoice.create(status: 2, customer_id: @customer.id)

        Transaction.create(invoice_id: @invoice1.id, result: 1)
        Transaction.create(invoice_id: @invoice1.id, result: 0)
        Transaction.create(invoice_id: @invoice2.id, result: 0)
        3.times do
          Transaction.create(invoice_id: @invoice3.id, result: 1)
        end

        InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item1.id, status: 1, quantity: 5, unit_price: 100)
        InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item2.id, status: 2, quantity: 2, unit_price: 200)
        InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item3.id, status: 0, quantity: 8, unit_price: 300)
        InvoiceItem.create(invoice_id: @invoice2.id, item_id: @item4.id, status: 1, quantity: 4, unit_price: 400)
        InvoiceItem.create(invoice_id: @invoice3.id, item_id: @item4.id, status: 1, quantity: 2, unit_price: 500)
        InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item5.id, status: 2, quantity: 5, unit_price: 500)
        InvoiceItem.create(invoice_id: @invoice2.id, item_id: @item6.id, status: 0, quantity: 6, unit_price: 700)
        InvoiceItem.create(invoice_id: @invoice3.id, item_id: @item7.id, status: 1, quantity: 5, unit_price: 800)
        InvoiceItem.create(invoice_id: @invoice2.id, item_id: @item8.id, status: 0, quantity: 5, unit_price: 700)

      end
      it "Items appear in order and show total revenue generate next to each item name" do
        visit("/merchants/#{@merchant1.id}/items")
        within("#TopFiveItems") do
          expect(page).to have_content("5 Most Popular Items by Revenue")
          expect("Item 6").to appear_before(": 4200")
          expect(": 4200").to appear_before("Item 5")
          expect("Item 5").to appear_before(": 2500")
          expect(": 2500").to appear_before("Item 3")
          expect("Item 3").to appear_before(": 2400")
          expect(": 2400").to appear_before("Item 4")
          expect("Item 4").to appear_before(": 1600")
          expect(": 1600").to appear_before("Item 1")
          expect("Item 1").to appear_before(": 500")
        end
      end
      
      it "Each Item name is a lnk to the item show page" do
        visit("/merchants/#{@merchant1.id}/items")
        within("#TopFiveItems") do
          click_link("Item 6")
          expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item6.id}")
          
          visit("/merchants/#{@merchant1.id}/items")
          click_link("Item 3")
          expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item3.id}")
        end
      end
    end
  end
end
