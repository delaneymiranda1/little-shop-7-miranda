require 'rails_helper' 

RSpec.describe Merchant, type: :feature do 
  before(:each) do 
    @merchant1 = Merchant.create(name: "Spongebob")
    @merchant2 = Merchant.create(name: "Plankton")

    @item1 = @merchant1.items.create(name: "Krabby Patty", description: "yummy", unit_price: "999")
    @item2 = @merchant1.items.create(name: "Diet Dr Kelp", description: "spicy", unit_price: "555")
    @item3 = @merchant1.items.create(name: "Pretty Pattie", description: "cute", unit_price: "333")
    @item4 = @merchant1.items.create(name: "Chum Bucket", description: "chummy", unit_price: "111")
    @item5 = @merchant1.items.create(name: "Pancakes", description: "fluffy", unit_price: "444")
    @item6 = @merchant1.items.create(name: "Crepes", description: "savory", unit_price: "888")
    @item7 = @merchant1.items.create(name: "Waffles", description: "thick", unit_price: "222")

    @customer1 = Customer.create(first_name: "Patrick", last_name: "Star")
    @customer2 = Customer.create(first_name: "Sandy", last_name: "Cheeks")
    @customer3 = Customer.create(first_name: "Misses", last_name: "Puff")

    @invoice1 = Invoice.create(status: 1, customer_id: @customer1.id)
    @invoice2 = Invoice.create(status: 1, customer_id: @customer2.id)
    @invoice3 = Invoice.create(status: 1, customer_id: @customer3.id)
    @invoice4 = Invoice.create(status: 1, customer_id: @customer3.id)


    @invoiceitem1 = InvoiceItem.create(quantity: 3, unit_price: 999, status: 1, invoice_id: @invoice1.id, item_id: @item1.id)
    @invoiceitem2 = InvoiceItem.create(quantity: 2, unit_price: 555, status: 1, invoice_id: @invoice2.id, item_id: @item2.id)
    @invoiceitem3 = InvoiceItem.create(quantity: 1, unit_price: 333, status: 1, invoice_id: @invoice1.id, item_id: @item3.id)
    @invoiceitem4 = InvoiceItem.create(quantity: 4, unit_price: 111, status: 1, invoice_id: @invoice3.id, item_id: @item4.id)
    @invoiceitem5 = InvoiceItem.create(quantity: 2, unit_price: 444, status: 0, invoice_id: @invoice3.id, item_id: @item5.id)
    @invoiceitem6 = InvoiceItem.create(quantity: 3, unit_price: 888, status: 0, invoice_id: @invoice4.id, item_id: @item6.id)
    @invoiceitem7 = InvoiceItem.create(quantity: 5, unit_price: 222, status: 1, invoice_id: @invoice4.id, item_id: @item7.id)
  end

  describe "US25. When I click on the name of a merchant from the admin merchants index page" do
    it "Then I am taken to that merchants admin show page (/admin/merchants/:merchant_id) where I see the name of the merchant" do
      visit "/admin/merchants"

      click_link("#{@merchant1.name}")
      expect(current_path).to eq("/admin/merchants/#{@merchant1.id}")
      expect(page).to have_content("#{@merchant1.name}")

      visit "/admin/merchants"
      click_link("#{@merchant2.name}")
      expect(current_path).to eq("/admin/merchants/#{@merchant2.id}")
      expect(page).to have_content("#{@merchant2.name}")
    end
  end

  describe "US17. When I visit my merchant invoice show page" do
    it "Then I see the total revenue that will be generated from all of my items on the invoice" do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content("Total Revenue: #{@total_revenue}")
      expect(page).to have_content("3330")

      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice2.id}"

      expect(page).to have_content("Total Revenue: #{@total_revenue}")
      expect(page).to have_content("1110")

      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice3.id}"

      expect(page).to have_content("Total Revenue: #{@total_revenue}")
      expect(page).to have_content("444")
    end
  end

  describe "US18. When I visit my merchant invoice show page" do
    xit "I see that each invoice item status is a select field 
    and I see that the invoice item's current status is selected" do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice3.id}"
      expect(page).to have_select("Status:", :with_options => ["packaged", "pending", "shipped"])
      expect(@item4.status).to eq("pending")
      expect(@item5.status).to eq("packaged")

      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice4.id}"
      expect(page).to have_select("Status:", :with_options => ["packaged", "pending", "shipped"])
      expect(@item6.status).to eq("packaged")
      expect(@item7.status).to eq("pending")
    end

    xit "I can select a new status for the Item, select Update Item Status, 
      get taken back to merchant invoice show page and see status has been updated" do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice3.id}"

      expect(page).to have_content("Update Item Status")

      within "#invoice-item-#{@item4.id}" do 
        select 'shipped', from: 'Status:'
        click_button 'Update Item Status'
      end

      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice3.id}")
      expect(page).to have_select('Status:', selected: 'shipped')

      within "#invoice-item-#{@item5.id}" do 
        select 'pending', from: 'Status:'
        click_button 'Update Item Status'
      end

      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice3.id}")
      expect(page).to have_select('Status:', selected: 'pending')

      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice4.id}"

      expect(page).to have_content("Update Item Status")

      within "#invoice-item-#{@item6.id}" do 
        select 'pending', from: 'Status:'
        click_button 'Update Item Status'
      end

      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice4.id}")
      expect(page).to have_select('Status:', selected: 'pending')

      within "#invoice-item-#{@item7.id}" do 
        select 'shipped', from: 'Status:'
        click_button 'Update Item Status'
      end

      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice4.id}")
      expect(page).to have_select('Status:', selected: 'shipped')
    end
  end
end