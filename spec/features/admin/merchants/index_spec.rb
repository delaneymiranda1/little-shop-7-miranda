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
  end 
end