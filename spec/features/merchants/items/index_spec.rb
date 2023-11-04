require 'rails_helper'

RSpec.describe 'Merchant items index page' do
  before(:each) do
    @merchant1 = Merchant.create(name: 'Merchant 1')
    @merchant2 = Merchant.create(name: 'Merchant 2')

    @item1 = @merchant1.items.create(name: 'Item 1', description: 'Description 1', unit_price: 1.00, active: true)
    @item2 = @merchant1.items.create(name: 'Item 2', description: 'Description 2', unit_price: 2.00, active: true)
    @item3 = @merchant2.items.create(name: 'Item 3', description: 'Description 3', unit_price: 3.00, active: true)
  end

  describe 'when a merchant visits their items index page' do
    it 'displays a list of the names of all of their items and does not display items for any other merchant' do
      visit "/merchants/#{@merchant1.id}/items"

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to_not have_content(@item3.name)
    end
  end
  
  describe 'when a merchant visits their items index page' do
    
    it 'displays a button to disable or enable each item' do
      visit "/merchants/#{@merchant1.id}/items"

      expect(page).to have_button('Disable', count: 2)
      expect(page).to_not have_button('Enable')
    end

    it 'changes the item status when the disable/enable button is clicked' do
      visit "/merchants/#{@merchant1.id}/items"

      click_button('Disable', match: :first)
save_and_open_page
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
      expect(page).to have_content('Status: inactive')
      expect(page).to have_button('Enable', count: 1)
      expect(page).to have_button('Disable', count: 1)

      click_button('Enable', match: :first)

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
      expect(page).to have_content('Status: active')
      expect(page).to have_button('Disable', count: 2)
      expect(page).to_not have_button('Enable')
    end
  end
end
