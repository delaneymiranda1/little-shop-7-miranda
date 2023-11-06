require 'rails_helper' 

RSpec.describe Merchant, type: :feature do 
  before(:each) do 
    @merchant1 = Merchant.create(name: "Spongebob", enabled: true)
    @merchant2 = Merchant.create(name: "Plankton" , enabled: true)

    @item1 = @merchant1.items.create(name: "Krabby Patty", description: "yummy", unit_price: "999")
    @item2 = @merchant1.items.create(name: "Diet Dr Kelp", description: "spicy", unit_price: "555")
    @item3 = @merchant1.items.create(name: "Pretty Pattie", description: "cute", unit_price: "333")
    @item4 = @merchant2.items.create(name: "Chum Bucket", description: "chummy", unit_price: "111")

    @customer1 = Customer.create(first_name: "Patrick", last_name: "Star")
    @customer2 = Customer.create(first_name: "Sandy", last_name: "Cheeks")
    @customer3 = Customer.create(first_name: "Misses", last_name: "Puff")

    @invoice1 = Invoice.create(status: 1, customer_id: @customer1.id)
    @invoice2 = Invoice.create(status: 1, customer_id: @customer2.id)
    @invoice3 = Invoice.create(status: 1, customer_id: @customer3.id)


    @invoiceitem1 = InvoiceItem.create(quantity: 3, unit_price: 999, status: 1, invoice_id: @invoice1.id, item_id: @item1.id)
    @invoiceitem2 = InvoiceItem.create(quantity: 2, unit_price: 555, status: 1, invoice_id: @invoice2.id, item_id: @item2.id)
    @invoiceitem3 = InvoiceItem.create(quantity: 1, unit_price: 333, status: 1, invoice_id: @invoice1.id, item_id: @item3.id)
    @invoiceitem4 = InvoiceItem.create(quantity: 4, unit_price: 111, status: 1, invoice_id: @invoice3.id, item_id: @item4.id)
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

      visit "/merchants/#{@merchant2.id}/invoices/#{@invoice3.id}"

      expect(page).to have_content("Total Revenue: #{@total_revenue}")
      expect(page).to have_content("444")

    end
  end
end
RSpec.describe Merchant, type: :feature do 
    before(:each) do
      @merchant1 = Merchant.create(name: "Spongebob", enabled: true)
      @merchant2 = Merchant.create(name: "Plankton", enabled: true)
      @merchant3 = Merchant.create(name: "Mr. Krabs", enabled: false)
      

    describe "US28. When I visit my admin merchant index" do
      it "then I see two sections, one for 'Enabled Merchants' and one for 'Disabled Merchants'" do
      
        visit "/admin/merchants"

        expect(page).to have_content("Enabled Merchants")
        expect(page).to have_content("Disabled Merchants")
      end

      it "and I see that each Merchant is listed in the appropriate section" do
        visit "/admin/merchants"

        within("#enabled-merchants") do
          expect(page).to have_content(@merchant1.name)
          expect(page).to have_content(@merchant2.name)
          expect(page).not_to have_content(@merchant3.name)
        end

        within("#disabled-merchants") do
          expect(page).to have_content(@merchant3.name)
          expect(page).not_to have_content(@merchant1.name)
          expect(page).not_to have_content(@merchant2.name)
        end
      end
    end
  end
end
