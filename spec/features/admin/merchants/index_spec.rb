require 'rails_helper' 

RSpec.describe Merchant, type: :feature do 
  before(:each) do 
    @merchant1 = Merchant.create(name: "Spongebob")
    @merchant2 = Merchant.create(name: "Plankton")
  end

  describe "US24. When I visit my admin merchant index " do 
    it "then I see the name of each merchant in the  system" do
      visit "/admin/merchants"
      expect(page).to have_content("#{@merchant1.name}")
      expect(page).to have_content("#{@merchant2.name}")
    end

    xit "each ID links to the merchant show page" do
      visit "/merchants/#{@merchant1.id}/invoices"
      click_link "#{@invoice1.id}"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")

      visit "/merchants/#{@merchant1.id}/invoices"
      click_link "#{@invoice2.id}"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice2.id}")
    end
  end 
end