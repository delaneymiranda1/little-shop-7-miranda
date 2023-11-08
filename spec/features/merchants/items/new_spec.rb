require 'rails_helper'

RSpec.feature "Merchant Item Create", type: :feature do
  before(:each) do
    @merchant1 = Merchant.create(name: 'Merchant 1', enabled: true)
    @merchant2 = Merchant.create(name: 'Merchant 2', enabled: true)

    @item1 = @merchant1.items.create(name: 'Item 1', description: 'Description 1', unit_price: 100, active: true)
    @item2 = @merchant1.items.create(name: 'Item 2', description: 'Description 2', unit_price: 200, active: true)
    @item3 = @merchant2.items.create(name: 'Item 3', description: 'Description 3', unit_price: 300, active: true)
  end

  it "merchant creates a new item" do
    visit "/merchants/#{@merchant1.id}/items"
    expect(page).to have_link("Create a New Item")
    click_link "Create a New Item"

    expect(current_path).to eq(new_merchant_item_path(@merchant1))

    fill_in "Name", with: "New Item"
    fill_in "Description", with: "This is a new item"
    fill_in "Unit price", with: 1099
  
    click_button "Submit"

    expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
    expect(page).to have_content("New Item")
    expect(page).to have_content("Status: inactive")
    click_link "New Item"

  end


  it "when item fails to save, it renders the new template" do
    visit "/merchants/#{@merchant1.id}/items"
    click_link "Create a New Item"

    fill_in "Name", with: ""
    fill_in "Description", with: ""
    fill_in "Unit price", with: ""
    
    click_button "Submit"

    expect(page).to have_content("Create a New Item")
  end
    
end
