require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

  
  describe "#instance methods" do
  describe "not_complete" do
    it "shows all the invoices marked as a status of cancelled (0) or in progress (1) and
    is ordered by created_at " do
      customer1 = Customer.create(first_name: "Patrick", last_name: "Star")
    
      invoice1 = Invoice.create(status: 0, customer_id: customer1.id)
      invoice2 = Invoice.create(status: 1, customer_id: customer1.id)

      invoice3 = Invoice.create(status: 1, customer_id: customer1.id)
      invoice4 = Invoice.create(status: 1, customer_id: customer1.id)
      invoice5 = Invoice.create(status: 1, customer_id: customer1.id)
    
      invoice6 = Invoice.create(status: 2, customer_id: customer1.id)
      invoice7 = Invoice.create(status: 2, customer_id: customer1.id)

      @invoices = Invoice.all 

      expect(@invoices.not_complete).to eq([invoice1, invoice2, invoice3, invoice4, invoice5])
      
      end
    end
  end
end