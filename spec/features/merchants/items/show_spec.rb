require 'rails_helper'

RSpec.describe 'Merchant Items Show Page', type: :feature do
  before (:each) do 
    @merchant1 = Merchant.create(name: 'Merchant 1')
    @merchant2 = Merchant.create(name: 'Merchant 2')

    @item1 = @merchant1.items.create(name: 'Item 1', description: 'Description 1', unit_price: 1.00, active: true)
    @item2 = @merchant1.items.create(name: 'Item 2', description: 'Description 2', unit_price: 2.00, active: true)
    @item3 = @merchant2.items.create(name: 'Item 3', description: 'Description 3', unit_price: 3.00, active: true)
  end
  describe 'when a merchant clicks on an item name from the merchant items index page' do
    it 'displays the item details on the item show page' do
      

      visit "/merchants/#{@merchant1.id}/items"
      click_link @item1.name

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.description)
      expect(page).to have_content(@item1.unit_price)
    end
  end
end
