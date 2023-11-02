class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def top_five_customers
    hash = customers.reduce({}) do |transaction_hash, customer|
      transaction_hash[customer] = Customer.find(customer.id).transactions.where(result: "success").count
      transaction_hash
    end
    sorted_hash = hash.sort_by { |key, value| -value }[0..4]
    require 'pry'; binding.pry
    names_only = sorted_hash.map do |customer| 
      "#{customer[0].first_name} #{customer[0].last_name}" 
    end

  end
end