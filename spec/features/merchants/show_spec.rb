require 'rails_helper' 

RSpec.describe Merchant, type: :feature do 
  before(:each) do 
    @merchant_1 = Merchant.create!(name: "Spongebob")

    # @item_1 = @merchant_1.create!(name: "Krabby Patty", description: "yummy", unit_price: "999")

  end

  describe "visiting the admin/namespace show page" do 
    describe "US1. When I visit my merchant dashboard" do
      it "Then I see the name of my merchant" do
        visit "/merchants/#{@merchant_1.id}/dashboard"

        expect(page).to have_content("Name: #{@merchant_1.name}")
      
      end
    end

    describe "US2. Then I see a link to my merchant items index" do
      it "And I see a link to my merchant invoices index" do
        visit "/merchants/#{@merchant_1.id}/dashboard"

        expect(page).to have_link("Merchant Items Index")
        click_link("Merchant Items Index")
        expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")

        visit "/merchants/#{@merchant_1.id}/dashboard"

        expect(page).to have_link("Merchant Invoices Index")
        click_link("Merchant Invoices Index")
        expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")

      end
    end
  end

  describe "US3. As a merchant, when I visit my merchant dashboard ('/merchants/:merchant_id/dashboard'" do
    it "Then I see the names of my top 5 customers who have completed the largest number of successful transaction with my merchant" do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      
    end

    it "And next to each customer name I see the number of successful transactions they have conducted with my merchant" do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      
    end
  end
end