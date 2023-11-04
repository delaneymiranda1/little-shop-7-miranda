require 'rails_helper' 

RSpec.describe "Admins Invoices Show", type: :feature do 
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

  describe "US33. When I visit my admin's invoices show " do 
    it "then I see information related to that invoice" do
      visit "/admin/invoices/#{@invoice1.id}"
      expect(page).to have_content("#{@invoice1.id}")
      expect(page).to have_content("#{@invoice1.status}")
      expect(page).to have_content("#{@invoice1.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("#{@customer1.first_name}")
      expect(page).to have_content("#{@customer1.last_name}")

      visit "/admin/invoices/#{@invoice2.id}"
      expect(page).to have_content("#{@invoice2.id}")
      expect(page).to have_content("#{@invoice2.status}")
      expect(page).to have_content("#{@invoice2.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("#{@customer2.first_name}")
      expect(page).to have_content("#{@customer2.last_name}")

      visit "/admin/invoices/#{@invoice3.id}"
      expect(page).to have_content("#{@invoice3.id}")
      expect(page).to have_content("#{@invoice3.status}")
      expect(page).to have_content("#{@invoice3.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("#{@customer3.first_name}")
      expect(page).to have_content("#{@customer3.last_name}")
    end
  end 

  #   34. Admin Invoice Show Page: Invoice Item Information

  # As an admin
  # When I visit an admin invoice show page (/admin/invoices/:invoice_id)
  # Then I see all of the items on the invoice including:
  # - Item name
  # - The quantity of the item ordered
  # - The price the Item sold for
  # - The Invoice Item status

  describe "US34. When I visit my admin's invoices show " do 
    it "then I see all the items on that invoice and their attributes" do
      visit "/admin/invoices/#{@invoice1.id}"
      
      expect(page).to have_content("#{@item1.name}")
      expect(page).to have_content("#{@invoiceitem1.quantity}")
      expect(page).to have_content("#{@item1.unit_price}")
      expect(page).to have_content("#{@invoiceitem1.status}")
      
      expect(page).to have_content("#{@item3.name}")
      expect(page).to have_content("#{@invoiceitem3.quantity}")
      expect(page).to have_content("#{@item3.unit_price}")
      expect(page).to have_content("#{@invoiceitem3.status}")

      visit "/admin/invoices/#{@invoice3.id}"

      expect(page).to have_content("#{@item4.name}")
      expect(page).to have_content("#{@invoiceitem4.quantity}")
      expect(page).to have_content("#{@item4.unit_price}")
      expect(page).to have_content("#{@invoiceitem4.status}")
    end
  end
end