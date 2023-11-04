require 'rails_helper'

RSpec.feature Merchant, type: :feature do
  before (:each) do
    @merchant1 = Merchant.create(name: 'Merchant 1')
  end 

  describe "As an admin, When I vsit the merchant's admin show page, I see a link to update the merchant's information" do
    it "When I click this link, I am taken to a page to edit this merchant, and I see a form  filled in with existing merchant attribute information" do
      visit "/admin/merchants/#{@merchant1.id}"
      click_link("Update Merchant 1")
      expect(current_path).to eq("/admin/merchants/#{@merchant1.id}/edit")
      expect(find_field("Name").value).to eq(@merchant1.name)
    end
    
    it "When I update the information in the form and click submit, I am redirected to the admin show page where I see the updated informations, and I see a flash message stating the information has been successfully updated" do
      visit "/admin/merchants/#{@merchant1.id}"
      expect(page).to_not have_content("The information has been successfully updated")
      click_link("Update Merchant 1")
      fill_in "Name", with: "New Merchant Name"
      click_button "Submit"

      expect(current_path).to eq("/admin/merchants/#{@merchant1.id}")
      expect(page).to have_content("New Merchant Name")
      expect(page).to have_content("The information has been successfully updated")
    end
  end
end