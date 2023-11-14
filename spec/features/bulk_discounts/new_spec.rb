require "rails_helper"

describe "Merchant Bulk Discount New" do
  before :each do
    @merchant1 = Merchant.create(name: "Spongebob")
    @merchant2 = Merchant.create(name: "Plankton" )

    @bulkdiscount1 = @merchant1.bulk_discounts.create!(quantity: 5, discount: 20)
    @bulkdiscount2 = @merchant1.bulk_discounts.create!(quantity: 10, discount: 25)
    @bulkdiscount3 = @merchant2.bulk_discounts.create!(quantity: 12, discount: 30)
  end
  # US 2
  describe "When I visit my bulk discounts index" do
    it "Then I see a link to create a new discount
      When I click this link
      Then I am taken to a new page where I see a form to add a new bulk discount
      When I fill in the form with valid data
      Then I am redirected back to the bulk discount index
      And I see my new bulk discount listed" do
      visit "/merchants/#{@merchant1.id}/bulk_discounts"

      click_link "Create New Bulk Discount"

      expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts/new")

      fill_in :quantity, with: "20"
      fill_in :discount, with: "15"

      click_button "Submit"

      expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts")
      expect(page).to have_content("Quantity: 20")
      expect(page).to have_content("Discount: 15")
    end
  end
end