require 'rails_helper' 

RSpec.describe "Admins Invoices Index", type: :feature do 
  before(:each) do 
    @merchant1 = Merchant.create(name: "Spongebob")
    @merchant2 = Merchant.create(name: "Plankton")

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


    @invoiceitem1 = InvoiceItem.create(quantity: 3, status: 1, invoice_id: @invoice1.id, item_id: @item1.id)
    @invoiceitem2 = InvoiceItem.create(quantity: 2, status: 1, invoice_id: @invoice2.id, item_id: @item2.id)
    @invoiceitem3 = InvoiceItem.create(quantity: 1, status: 1, invoice_id: @invoice1.id, item_id: @item3.id)
    @invoiceitem4 = InvoiceItem.create(quantity: 4, status: 1, invoice_id: @invoice3.id, item_id: @item4.id)
  end

  describe "US32. When I visit my admins invoices index " do 
    it "then I see all of the invoices IDs in the system" do
      visit "/admin/invoices"
      
      expect(page).to have_content("#{@invoice1.id}")
      expect(page).to have_content("#{@invoice2.id}")
      expect(page).to have_content("#{@invoice3.id}")
    end

    it "each ID links to the admin invoice show page" do
      visit "/admin/invoices"

      click_link "#{@invoice1.id}"
      expect(current_path).to eq("/admin/invoices/#{@invoice1.id}")

      visit "/admin/invoices"
      click_link "#{@invoice2.id}"
      expect(current_path).to eq("/admin/invoices/#{@invoice2.id}")
    end
  end 
end