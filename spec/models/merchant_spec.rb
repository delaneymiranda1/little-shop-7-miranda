require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  
  describe "#instance_methods" do
    describe "items_to_ship" do
      it "shows all invoice_items that have a status of 'pending' that are associated with 
      this specific merchant" do
        merchant = Merchant.create!(name: "Spongebob")

        customer1 = Customer.create!(first_name: "Sandy", last_name: "Cheeks")
        customer2 = Customer.create!(first_name: "Mermaid", last_name: "Man")
        customer3 = Customer.create!(first_name: "Sandy", last_name: "Cheeks")

        item1 = Item.create!(name: "Krabby Patty", description: "Yummy", unit_price: 10, merchant_id: merchant.id)
        item2 = Item.create!(name: "Chum Burger", description: "Not As Yummy", unit_price: 9, merchant_id: merchant.id)
        item3 = Item.create!(name: "Krabby Patty with Jelly", description: "Damn Good", unit_price: 12, merchant_id: merchant.id)

        invoice1 = Invoice.create!(status: 1, customer_id: customer1.id)
        invoice2 = Invoice.create!(status: 1, customer_id: customer2.id)
        invoice3 = Invoice.create!(status: 1, customer_id: customer3.id)

        invoice_item1 = InvoiceItem.create!(quantity: 4, unit_price: 40, status: 1, invoice_id: invoice1.id, item_id: item1.id)
        invoice_item2 = InvoiceItem.create!(quantity: 4, unit_price: 36, status: 1, invoice_id: invoice2.id, item_id: item2.id)
        invoice_item3 = InvoiceItem.create!(quantity: 4, unit_price: 48, status: 1, invoice_id: invoice3.id, item_id: item3.id)
      

        expect(merchant.items_to_ship).to eq([invoice_item1, invoice_item2, invoice_item3])
      end
    end  
  end

  before :each do
    @merchant1 = Merchant.create(name: "Spongebob")
      
    @item1 = @merchant1.items.create(name: "Krabby Patty", description: "yummy", unit_price: "999")
    @item2 = @merchant1.items.create(name: "Krabby Patty", description: "yummy", unit_price: "999")

    @customer1 = Customer.create(first_name: "Patrick", last_name: "Star")
    @customer2 = Customer.create(first_name: "Sandy", last_name: "Cheeks")
    @customer3 = Customer.create(first_name: "King", last_name: "Neptune")
    @customer4 = Customer.create(first_name: "Eugene", last_name: "Krabs")
    @customer5 = Customer.create(first_name: "Sheldon", last_name: "Plankton")
    @customer6 = Customer.create(first_name: "Poppy", last_name: "Puff")

    @invoice1 = Invoice.create(status: 1, customer_id: @customer1.id)
    @invoice2 = Invoice.create(status: 1, customer_id: @customer2.id)
    @invoice3 = Invoice.create(status: 1, customer_id: @customer3.id)
    @invoice4 = Invoice.create(status: 1, customer_id: @customer4.id)
    @invoice5 = Invoice.create(status: 1, customer_id: @customer5.id)
    @invoice6 = Invoice.create(status: 1, customer_id: @customer6.id)

    @invoiceitem1 = InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item1.id)
    @invoiceitem2 = InvoiceItem.create(invoice_id: @invoice2.id, item_id: @item1.id)
    @invoiceitem3 = InvoiceItem.create(invoice_id: @invoice3.id, item_id: @item1.id)
    @invoiceitem4 = InvoiceItem.create(invoice_id: @invoice4.id, item_id: @item2.id)
    @invoiceitem5 = InvoiceItem.create(invoice_id: @invoice5.id, item_id: @item1.id)
    @invoiceitem6 = InvoiceItem.create(invoice_id: @invoice6.id, item_id: @item1.id)
    
    Transaction.create(invoice_id: @invoice1.id, result: 0)
    Transaction.create(invoice_id: @invoice2.id, result: 0)
    Transaction.create(invoice_id: @invoice2.id, result: 0)
    3.times do
      Transaction.create(invoice_id: @invoice3.id, result: 1)
    end
    4.times do
      Transaction.create(invoice_id: @invoice4.id, result: 0)
    end
    5.times do
      Transaction.create(invoice_id: @invoice5.id, result: 0)
    end
    5.times do
      Transaction.create(invoice_id: @invoice5.id, result: 1)
    end
    6.times do
      Transaction.create(invoice_id: @invoice6.id, result: 0)
    end

    @merchant2 = Merchant.create(name: "Squidward")
    @item3 = @merchant2.items.create(name: "Krabby Patty", description: "yummy", unit_price: "999")
    @customer7 = Customer.create(first_name: "Larry", last_name: "Lobster")
    @invoice7 = Invoice.create(status: 1, customer_id: @customer7.id)
    @invoiceitem7 = InvoiceItem.create(invoice_id: @invoice7.id, item_id: @item3.id)
    3.times do
      Transaction.create(invoice_id: @invoice7.id, result: 0)
    end
  end

  describe '#top_five_customers' do
    it "should return the 5 customers with the most successful transactions wiht attributes intact" do
      expect(@merchant1.top_five_customers).to eq([@customer6, @customer5, @customer4, @customer2, @customer1])
      expect(@merchant1.top_five_customers.first.successful_transactions).to eq(6)
      expect(@merchant1.top_five_customers.first.first_name).to eq("Poppy")
      expect(@merchant1.top_five_customers.first.last_name).to eq("Puff")
    end
  end
  
  describe '#self.top_five_customers' do
    it "should return the 5 customers with the most successful transactions wiht attributes intact" do
      expect(Merchant.top_five_customers).to eq([@customer6, @customer5, @customer4, @customer7, @customer2])
      expect(Merchant.top_five_customers.first.successful_transactions).to eq(6)
      expect(Merchant.top_five_customers.first.first_name).to eq("Poppy")
      expect(Merchant.top_five_customers.first.last_name).to eq("Puff")
    end
  end

  describe '#enabled?' do
    it 'returns the enabled status of the merchant' do
      merchant = Merchant.create(name: "Test Merchant", enabled: true)
      expect(merchant.enabled?).to eq(true)

      merchant.update(enabled: false)
      expect(merchant.enabled?).to eq(false)
    end
  end

  describe '#top_five_items' do
    before :each do
      @merchant1 = Merchant.create(name: 'Merchant 1', enabled: true)
      @merchant2 = Merchant.create(name: 'Merchant 2', enabled: true)
  
      @item1 = @merchant1.items.create(name: 'Item 1', description: 'Description 1', unit_price: 100, active: true)
      @item2 = @merchant1.items.create(name: 'Item 2', description: 'Description 2', unit_price: 200, active: true)
      @item3 = @merchant1.items.create(name: 'Item 3', description: 'Description 1', unit_price: 300, active: true)
      @item4 = @merchant1.items.create(name: 'Item 4', description: 'Description 1', unit_price: 100, active: true)
      @item5 = @merchant1.items.create(name: 'Item 5', description: 'Description 2', unit_price: 200, active: true)
      @item6 = @merchant1.items.create(name: 'Item 6', description: 'Description 3', unit_price: 300, active: true)
      @item7 = @merchant1.items.create(name: 'Item 7', description: 'Description 3', unit_price: 300, active: true)
      @item8 = @merchant2.items.create(name: 'Item 8', description: 'Description 3', unit_price: 10000, active: true)

      @customer = Customer.create(first_name: "Patrick", last_name: "Star")
      @invoice1 = Invoice.create(status: 2, customer_id: @customer.id)
      @invoice2 = Invoice.create(status: 2, customer_id: @customer.id)
      @invoice3 = Invoice.create(status: 2, customer_id: @customer.id)

      Transaction.create(invoice_id: @invoice1.id, result: 1)
      Transaction.create(invoice_id: @invoice1.id, result: 0)
      Transaction.create(invoice_id: @invoice2.id, result: 0)
      3.times do
        Transaction.create(invoice_id: @invoice3.id, result: 1)
      end

      InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item1.id, status: 1, quantity: 5, unit_price: 100)
      InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item2.id, status: 2, quantity: 2, unit_price: 200)
      InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item3.id, status: 0, quantity: 8, unit_price: 300)
      InvoiceItem.create(invoice_id: @invoice2.id, item_id: @item4.id, status: 1, quantity: 4, unit_price: 400)
      InvoiceItem.create(invoice_id: @invoice3.id, item_id: @item4.id, status: 1, quantity: 2, unit_price: 500)
      InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item5.id, status: 2, quantity: 5, unit_price: 500)
      InvoiceItem.create(invoice_id: @invoice2.id, item_id: @item6.id, status: 0, quantity: 6, unit_price: 700)
      InvoiceItem.create(invoice_id: @invoice3.id, item_id: @item7.id, status: 1, quantity: 5, unit_price: 800)
      InvoiceItem.create(invoice_id: @invoice2.id, item_id: @item8.id, status: 0, quantity: 5, unit_price: 700)
    end
    it 'returns the top 5 items of a merchant by revenue' do
      # expect(@merchant1.top_five_items.count).to eq(5)
      expect(@merchant1.top_five_items[0].id).to eq(@item6.id)
      expect(@merchant1.top_five_items[1].id).to eq(@item5.id)
      expect(@merchant1.top_five_items[2].id).to eq(@item3.id)
      expect(@merchant1.top_five_items[3].id).to eq(@item4.id)
      expect(@merchant1.top_five_items[4].id).to eq(@item1.id)
      expect(@merchant1.top_five_items[5]).to eq(nil)
    end

    it 'stores the revenue' do
      expect(@merchant1.top_five_items.first.revenue).to eq(4200)
      expect(@merchant1.top_five_items[3].revenue).to eq(1600)
      expect(@merchant1.top_five_items.last.revenue).to eq(500)
    end 
  end
end