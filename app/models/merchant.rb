class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def items_to_ship 
    # invoice_items.where(status: "pending").order(:created_at)
    
    # item_id = InvoiceItem.where(status: "pending").order(:created_at).pluck(:item_id)
    require 'pry';binding.pry
  invoice_items
    .joins(:items)
    .select("items.name, invoice_id, item_id")
    .where(status: "pending")
    .group("items.id, :item_id, :invoice_id")
    .order(:item_id).first.name
  end
end

# Merchant.find(20).items
# Merchant.find(27).items.find(37).invoice_items.pluck(:status)