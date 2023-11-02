require 'rails_helper'

RSpec.describe 'Merchant items index page' do
  before(:each) do
    @merchant_1 = Merchant.create(name: 'Merchant 1')
    @merchant_2 = Merchant.create(name: 'Merchant 2')

    @item_1 = @merchant_1.items.create(name: 'Item 1', description: 'Description 1', unit_price: 1.00)
    @item_2 = @merchant_1.items.create(name: 'Item 2', description: 'Description 2', unit_price: 2.00)
    @item_3 = @merchant_2.items.create(name: 'Item 3', description: 'Description 3', unit_price: 3.00)
  end

  describe 'when a merchant visits their items index page' do
    it 'git checkdisplays a list of the names of all of their items and does not display items for any other merchant' do
      visit "/merchants/#{@merchant_1.id}/items"

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)
    end
  end
end
