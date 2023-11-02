require 'rails_helper' 

RSpec.describe "Merchants Invoices Show", type: :feature do 
  before(:each) do 
    @merchant1 = Merchant.create(name: "Spongebob")

    @item1 = @merchant1.items.create(name: "Krabby Patty", description: "yummy", unit_price: "999")
    @item2 = @merchant1.items.create(name: "Diet Dr Kelp", description: "spicy", unit_price: "555")

    @customer1 = Customer.create(first_name: "Patrick", last_name: "Star")
    @customer2 = Customer.create(first_name: "Sandy", last_name: "Cheeks")

    @invoice1 = Invoice.create(status: 1, customer_id: @customer1.id)
    @invoice2 = Invoice.create(status: 1, customer_id: @customer2.id)

    @invoiceitem1 = InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item1.id)
    @invoiceitem2 = InvoiceItem.create(invoice_id: @invoice2.id, item_id: @item2.id)
  end

  describe "US15. When I visit my merchant's invoices show " do 
    it "then I see information related to that invoice" do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"
      expect(page).to have_content("#{@invoice1.id}")
      expect(page).to have_content("#{@invoice1.status}")
      expect(page).to have_content("#{@invoice1.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("#{@customer1.first_name}")
      expect(page).to have_content("#{@customer1.last_name}")

      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice2.id}"
      expect(page).to have_content("#{@invoice2.id}")
      expect(page).to have_content("#{@invoice2.status}")
      expect(page).to have_content("#{@invoice2.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("#{@customer2.first_name}")
      expect(page).to have_content("#{@customer2.last_name}")
      save_and_open_page
    end
  end 
end