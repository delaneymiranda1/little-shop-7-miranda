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
      expect(page).to have_content("Discount: 20% off")

      visit "/merchants/#{@merchant2.id}/bulk_discounts/#{@bulkdiscount4.id}"
      expect(page).to have_content("Quantity Needed to Purchase for Discount to Apply: 15")
      expect(page).to have_content("Discount: 15% off")
    end
  end

  # US 5
  describe "When I visit my bulk discount show page" do
    it 'Then I see a link to edit the bulk discount
      When I click this link
      Then I am taken to a new page with a form to edit the discount
      And I see that the discounts current attributes are pre-poluated in the form
      When I change any/all of the information and click submit
      Then I am redirected to the bulk discounts show page
      And I see that the discounts attributes have been updated' do
      visit "/merchants/#{@merchant1.id}/bulk_discounts/#{@bulkdiscount1.id}"
      expect(page).to have_content("Edit this Discount")

      click_link "Edit this Discount"

      expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts/#{@bulkdiscount1.id}/edit")
      expect(find_field("Quantity").value).to eq("5")
      expect(find_field("Discount").value).to eq("20")

      fill_in "Quantity", with: "7"
      fill_in "Discount", with: "23"
      click_button "Submit"

      expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts/#{@bulkdiscount1.id}")
      expect(page).to_not have_content("Quantity Needed to Purchase for Discount to Apply: 5")
      expect(page).to_not have_content("Discount: 20% off")
    
      expect(page).to have_content("Quantity Needed to Purchase for Discount to Apply: 7")
      expect(page).to have_content("Discount: 23% off")
    end
  end
end