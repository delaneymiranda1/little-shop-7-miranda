require 'rails_helper' 

RSpec.describe Merchant, type: :feature do 
  before(:each) do 

    @merchant1 = Merchant.create(name: "Spongebob", enabled: true)
    @merchant2 = Merchant.create(name: "Plankton", enabled: true)
  end

  describe "US24. When I visit my admin merchant index " do 
    it "then I see the name of each merchant in the  system" do
      visit "/admin/merchants"
      expect(page).to have_content("#{@merchant1.name}")
      expect(page).to have_content("#{@merchant2.name}")
    end
  end 

  
  describe "US27. When I visit my admin merchant index" do
    it "next to each merchant name I see a button to disable or enable that merchant" do
      visit "/admin/merchants"

      expect(page).to have_button("Disable", count: 2)
      expect(page).to have_button("Enable", count: 0)
    end

    it "when I click the disable button, I am redirected back to the admin merchants index and the merchant's status has changed" do
      visit "/admin/merchants"
      expect(page).to have_button("Disable", count: 2)

      click_button("Disable", match: :first)
      expect(current_path).to eq("/admin/merchants")


      expect(page).to have_button("Enable", count: 1)
      expect(page).to have_button("Disable", count: 1)

      click_button("Disable", match: :first)
      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_button("Enable", count: 2)
      expect(page).to have_button("Disable", count: 0)
    end
  end
end

RSpec.describe Merchant, type: :feature do
  before :each do
    @merchant1 = Merchant.create(name: 'Merchant 1', enabled: true)
    @merchant2 = Merchant.create(name: 'Merchant 2', enabled: true)
    @merchant3 = Merchant.create(name: 'Merchant 3', enabled: true)
    @merchant4 = Merchant.create(name: 'Merchant 4', enabled: true)
    @merchant5 = Merchant.create(name: 'Merchant 5', enabled: true)
    @merchant6 = Merchant.create(name: 'Merchant 6', enabled: true)
    @merchant7 = Merchant.create(name: 'Merchant 7', enabled: true)

    @item1 = @merchant1.items.create(name: 'Item 1', description: 'Description 1', unit_price: 100, active: true)
    @item2 = @merchant2.items.create(name: 'Item 2', description: 'Description 2', unit_price: 200, active: true)
    @item3 = @merchant3.items.create(name: 'Item 3', description: 'Description 1', unit_price: 300, active: true)
    @item4 = @merchant4.items.create(name: 'Item 4', description: 'Description 1', unit_price: 100, active: true)
    @item5 = @merchant5.items.create(name: 'Item 5', description: 'Description 2', unit_price: 200, active: true)
    @item6 = @merchant6.items.create(name: 'Item 6', description: 'Description 3', unit_price: 300, active: true)
    @item7 = @merchant7.items.create(name: 'Item 7', description: 'Description 3', unit_price: 300, active: true)
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

  describe "US 30 - When I visit the admin merchants index, I see the name of the top 5 merchants by total revenue generated" do
    it "And I see the total revenue generated next to each merchant name" do
      visit("/admin/merchants")
      within("#TopFiveMerchants") do
        expect(page).to have_content("5 Most Popular Items by Revenue")
        expect("Merchant 6").to appear_before(": 4200")
        expect(": 4200").to appear_before("Merchant 2")
        expect("Merchant 2").to appear_before(": 3900")
        expect(": 3900").to appear_before("Merchant 5")
        expect("Merchant 5").to appear_before(": 2500")
        expect(": 2500").to appear_before("Merchant 3")
        expect("Merchant 3").to appear_before(": 2400")
        expect(": 2400").to appear_before("Merchant 4")
        expect("Merchant 4").to appear_before(": 1600")
      end
    end

    it "And I see that each merchant name links to the asmin merchant show page for that merchant" do
      visit("/admin/merchants")
      within("#TopFiveMerchants") do
        click_link("Merchant 6")
        expect(current_path).to eq("/admin/merchants/#{@merchant6.id}")
        
        visit("/admin/merchants")
        click_link("Merchant 3")
        expect(current_path).to eq("/admin/merchants/#{@merchant3.id}")
      end
    end
  end
end