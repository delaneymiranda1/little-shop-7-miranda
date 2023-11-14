require "rails_helper"

describe "Merchant Bulk Discounts Show" do
  before :each do
    @merchant1 = Merchant.create(name: "Spongebob", enabled: true)
    @merchant2 = Merchant.create(name: "Plankton" , enabled: true)

    @bulkdiscount1 = @merchant1.bulk_discounts.create!(quantity: 5, discount: 20)
    @bulkdiscount2 = @merchant1.bulk_discounts.create!(quantity: 10, discount: 25)
    @bulkdiscount3 = @merchant2.bulk_discounts.create!(quantity: 12, discount: 30)
    @bulkdiscount4 = @merchant2.bulk_discounts.create!(quantity: 15, discount: 15)
  end
  # US 4
  describe "When I visit my bulk discount show page" do
    it 'Then I see the bulk discounts quantity threshold and percentage discount' do
      visit "/merchants/#{@merchant1.id}/bulk_discounts/#{@bulkdiscount1.id}"
      expect(page).to have_content("Quantity Needed to Purchase for Discount to Apply: 5")
      expect(page).to have_content("Discount: 20")

      visit "/merchants/#{@merchant2.id}/bulk_discounts/#{@bulkdiscount4.id}"
      expect(page).to have_content("Quantity Needed to Purchase for Discount to Apply: 15")
      expect(page).to have_content("Discount: 15")
    end
  end



end