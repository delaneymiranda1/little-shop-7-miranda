require 'rails_helper' 

RSpec.describe Merchant, type: :feature do 
  before(:each) do 
    @merchant1 = Merchant.create(name: "Spongebob")
    @merchant2 = Merchant.create(name: "Plankton")
  end

    describe "US25. When I click on the name of a merchant from the admin merchants index page" do
      it "Then I am taken to that merchants admin show page (/admin/merchants/:merchant_id) where I see the name of the merchant" do
        visit "/admin/merchants"

        click_link("#{@merchant1.name}")
        expect(current_path).to eq("/admin/merchants/#{@merchant1.id}")
        expect(page).to have_content("#{@merchant1.name}")

        visit "/admin/merchants"

        click_link("#{@merchant2.name}")
        expect(current_path).to eq("/admin/merchants/#{@merchant2.id}")
        expect(page).to have_content("#{@merchant2.name}")
      end
    end

  
  end