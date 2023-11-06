class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  def items_to_ship 
    invoice_items 
    .where(status: "pending")
  end

  def top_five_customers
    Customer.joins(:items).joins(:transactions).select("customers.id, customers.first_name, customers.last_name, count(customers.id) as successful_transactions").where("items.merchant_id = ? and transactions.result = 0", self.id).group('customers.id').order(successful_transactions: :desc).limit(5)
  end
  
  def self.top_five_customers
    Customer.joins(:items).joins(:transactions).select("customers.id, customers.first_name, customers.last_name, count(customers.id) as successful_transactions").where("transactions.result = 0").group('customers.id').order(successful_transactions: :desc).limit(5)
  end

  def disabled_items 
    Item.where("active = false and merchant_id = #{self.id}")
  end

  def enabled_items 
    Item.where("active = true and merchant_id = #{self.id}")
  end

  def top_five_items
    Item.joins(:transactions).select("items.id, items.name, sum(invoice_items.unit_price * invoice_items.quantity) as revenue").where("items.merchant_id = #{self.id} and transactions.result = 0").group('items.id').order(revenue: :desc).limit(5)
  end
end