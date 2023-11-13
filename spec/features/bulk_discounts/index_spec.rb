require "rails_helper"

describe "merchant bulk discounts index" do
  before :each do
    @merchant1 = Merchant.create(name: "Spongebob", enabled: true)
    @merchant2 = Merchant.create(name: "Plankton" , enabled: true)

    @bulkdiscount1 = @merchant1.bulk_discounts.create!(quantity: 5, discount: 20)
    @bulkdiscount2 = @merchant1.bulk_discounts.create!(quantity: 10, discount: 25)
    @bulkdiscount3 = @merchant2.bulk_discounts.create!(quantity: 12, discount: 30)
  end
  # US 1
  describe "As a merchant When I visit my merchant dashboard" do
    describe "Then I see a link to view all my discounts When I click this link Then I am taken to my bulk discounts index page" do
      it "Where I see all of my bulk discounts including their percentage discount and quantity thresholds" do
        visit "/merchants/#{@merchant1.id}/dashboard"
        click_link "Bulk Discounts"
        expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts")
        expect(page).to have_content("Bulk Discounts:")
        expect(page).to have_content("Quantity: 5")
        expect(page).to have_content("Quantity: 10")
        expect(page).to have_content("Quantity: 12")
        expect(page).to have_content("Discount: 20")
        expect(page).to have_content("Discount: 25")
        expect(page).to have_content("Discount: 30")
      end
      it "And each bulk discount listed includes a link to its show page" do 
        visit "/merchants/#{@merchant1.id}/bulk_discounts"

        click_link "Discount: 20"
        expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts/#{@bulkdiscount1.id}")

      end
    end
  end
  # US 3
  describe "When I visit my bulk discounts index" do
    it 'Then next to each bulk discount I see a button to delete it
      When I click this button
      Then I am redirected back to the bulk discounts index page
      And I no longer see the discount listed' do
      visit "/merchants/#{@merchant1.id}/bulk_discounts"
      expect(page).to have_content("Spongebob's Bulk Discounts:")
      expect(page).to have_content("Quantity: 5")
      expect(page).to have_content("Discount: 20")
      expect(page).to have_content("Quantity: 10")
      expect(page).to have_content("Discount: 25")
      click_button "Delete Bulk Discount #{@bulk_discount1.id}"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts")
      expect(page).to_not have_content("Quantity: 5")
      expect(page).to_not have_content("Discount: 20")
      expect(page).to have_content("Quantity: 10")
      expect(page).to have_content("Discount: 25")
    end
    end
  end
end