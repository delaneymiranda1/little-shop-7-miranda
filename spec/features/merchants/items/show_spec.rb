require 'rails_helper'

RSpec.describe 'Merchant Items Show Page', type: :feature do
  describe 'when a merchant clicks on an item name from the merchant items index page' do
    it 'displays the item details on the item show page' do
      @merchant_1 = Merchant.create(name: 'Merchant 1')
      @merchant_2 = Merchant.create(name: 'Merchant 2')

      @item_1 = @merchant_1.items.create(name: 'Item 1', description: 'Description 1', unit_price: 1.00)
      @item_2 = @merchant_1.items.create(name: 'Item 2', description: 'Description 2', unit_price: 2.00)
      @item_3 = @merchant_2.items.create(name: 'Item 3', description: 'Description 3', unit_price: 3.00)

      visit "/merchants/#{@merchant_1.id}/items"
      click_link @item_1.name

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/#{@item_1.id}")

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@item_1.unit_price)
    end
  end
end
