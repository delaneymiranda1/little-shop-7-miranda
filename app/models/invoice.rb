class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items


  enum status: { cancelled: 0, "in progress": 1, completed: 2 }

  def self.not_complete
    where("status = 0 OR status = 1").order(created_at: :asc)
  end
end