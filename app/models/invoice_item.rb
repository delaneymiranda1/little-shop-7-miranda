class InvoiceItem < ApplicationRecord
  belongs_to :invoice, dependent: :destroy
  belongs_to :item, dependent: :destroy

enum status: { packaged: 0, pending: 1, shipped: 2 }

  def item_name
    self.item.name
  end
end