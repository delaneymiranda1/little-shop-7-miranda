require 'rails_helper'

RSpec.feature "Merchant Item Update", type: :feature do
  before (:each) do
    @merchant1 = Merchant.create(name: 'Merchant 1')

    @item1 = @merchant1.items.create(name: 'Item 1', description: 'Description 1', unit_price: 10)
    

  end 
  describe "I visit the merchant show page of an item (/merchants/:merchant_id/items/:item_id)" do 
    describe "I see a link to update the item information and I click the link" do 
      describe "I am taken to a page to edit this item and I see a form filled in with the existing item attribute information" do 
        describe "I update the information in the form and I click ‘submit’" do 
          it "merchant updates an item" do
          visit "/merchants/#{@merchant1.id}/items/#{@item1.id}"

          expect(page).to have_link("Update Item")

          click_link "Update Item"

          expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}/edit")
          expect(find_field("Name").value).to eq(@item1.name)
          expect(find_field("Description").value).to eq(@item1.description)
          expect(find_field("Unit price").value).to eq(@item1.unit_price.to_s)
          
          fill_in "Name", with: "New Item Name"
          fill_in "Description", with: "New Item Description"
          fill_in "Unit price", with: "999"
      

          click_button "Submit"

          expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")
          expect(page).to have_content("New Item Name")
          expect(page).to have_content("New Item Description")
          expect(page).to have_content("$9.99")
          expect(page).to have_content("The information has been successfully updated")
          end 
        end 
      end 
    end
  end
end
