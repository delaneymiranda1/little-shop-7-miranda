class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants


  enum status: { cancelled: 0, "in progress": 1, completed: 2 }

  def self.not_complete
    where("status = 0 OR status = 1").order(created_at: :asc)
  end

  def total_revenue
    invoice_items.sum('unit_price * quantity')
  end

  def customer_name
    "#{customer.first_name} #{customer.last_name}"
  end

  def formatted_date
    created_at.strftime("%A, %B %d, %Y")
  end

  def total_discounted_revenue
    total_revenue - discount_helper
  end

  def discount_helper
    invoice_items.select("invoice_items.id, MAX(bulk_discounts.discount) /100.0 * 
      (invoice_items.unit_price * invoice_items.quantity) as total_discounted_revenue")
      .joins(item: {merchant: :bulk_discounts})
      .where("invoice_items.quantity >= bulk_discounts.quantity")
      .group("invoice_items.id")
      .sum(&:total_discounted_revenue)
  end
end