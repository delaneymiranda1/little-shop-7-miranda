require 'rails_helper' 

RSpec.describe Merchant, type: :feature do 
  before(:each) do 

    @merchant1 = Merchant.create(name: "Spongebob", enabled: true)
    @merchant2 = Merchant.create(name: "Plankton", enabled: true)
  end

  describe "US24. When I visit my admin merchant index " do 
    it "then I see the name of each merchant in the  system" do
      visit "/admin/merchants"
      expect(page).to have_content("#{@merchant1.name}")
      expect(page).to have_content("#{@merchant2.name}")
    end
  end 

  
  describe "US27. When I visit my admin merchant index" do
    it "next to each merchant name I see a button to disable or enable that merchant" do
      visit "/admin/merchants"
      expect(page).to have_button("Disable", count: 2)
      expect(page).to have_button("Enable", count: 0)
    end

    it "when I click the disable button, I am redirected back to the admin merchants index and the merchant's status has changed" do
      visit "/admin/merchants"
      expect(page).to have_button("Disable", count: 2)

      click_button("Disable", match: :first)
      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_button("Enable", count: 1)
      expect(page).to have_button("Disable", count: 1)

      click_button("Disable", match: :first)
      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_button("Enable", count: 2)
      expect(page).to have_button("Disable", count: 0)
    end
  end
end