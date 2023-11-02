require 'rails_helper' 

RSpec.describe "Admin Dashboard Page", type: :feature do 
  before(:each) do 
    

  end

  describe "visiting the admin/namespace show page" do 
    describe "" do
      it "" do
        visit "/admin"

        expect(page).to have_content("Welcome to the Admin Dashboard, Boss")
      
      end
    end
  end
end