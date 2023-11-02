require 'rails_helper' 

RSpec.describe Merchant, type: :feature do 
  before(:each) do 
    @merchant_list = create_list(:merchant , 1)
    @item1 = create(:item, merchant: @merchant_list.sample)
    @customer_list = create_list(:customer, 10)
    @invoice_list = []
    10.times do
      @invoice_list << create(:invoice, customer: @customer_list.sample)
    end
    @invoice_item_list = []
    10.times do
      @invoice_item_list << create(:invoice_item, invoice: @invoice_list.sample, item: @item1)
    end
    @transaction_list = []
    10.times do
      @transaction_list << create(:transaction, invoice: @invoice_list.sample)
    end
    

    # @item_1 = @merchant_1.create!(name: "Krabby Patty", description: "yummy", unit_price: "999")

  end

  describe "visiting the admin/namespace show page" do 
    describe "US1. When I visit my merchant dashboard" do
      it "Then I see the name of my merchant" do
        visit "/merchants/#{@merchant_list.first.id}/dashboard"

        expect(page).to have_content("Name: #{@merchant_list.first.name}")
      
      end
    end

    describe "US2. Then I see a link to my merchant items index" do
      it "And I see a link to my merchant invoices index" do
        visit "/merchants/#{@merchant_list.first.id}/dashboard"

        expect(page).to have_link("Merchant Items Index")
        click_link("Merchant Items Index")
        expect(current_path).to eq("/merchants/#{@merchant_list.first.id}/items")

        visit "/merchants/#{@merchant_list.first.id}/dashboard"

        expect(page).to have_link("Merchant Invoices Index")
        click_link("Merchant Invoices Index")
        expect(current_path).to eq("/merchants/#{@merchant_list.first.id}/invoices")

      end
    end
  end
  
  describe "US3. As a merchant, when I visit my merchant dashboard ('/merchants/:merchant_id/dashboard'" do
    it "Then I see the names of my top 5 customers who have completed the largest number of successful transaction with my merchant" do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)
      customer_list = create_list(:customer, 10)
      invoice_list = []
      customer_list.each do |customer|
        invoice_list << create(:invoice, customer: customer)
      end
      invoice_item_list = []
      invoice_list.each do |invoice|
        invoice_item_list << create(:invoice_item, invoice: invoice, item: item)
      end
      transaction_list = []
      1000.times do
        transaction_list << create(:transaction, invoice: invoice_list.sample)
      end
      visit "/merchants/#{merchant.id}/dashboard"
      require 'pry'; binding.pry
    end

    it "And next to each customer name I see the number of successful transactions they have conducted with my merchant" do
      visit "/merchants/#{@merchant_list.first.id}/dashboard"
      
    end
  end
end