class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def top_five_customers
    Customer.joins(:items).joins(:transactions).select("customers.id, customers.first_name, customers.last_name, count(customers.id) as successful_transactions").where("items.merchant_id = ? and transactions.result = 0", self.id).group('customers.id').order(successful_transactions: :desc).limit(5)
  end
  
  def self.top_five_customers
    Customer.joins(:items).joins(:transactions).select("customers.id, customers.first_name, customers.last_name, count(customers.id) as successful_transactions").where("transactions.result = 0").group('customers.id').order(successful_transactions: :desc).limit(5)
  end
end