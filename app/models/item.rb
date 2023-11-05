class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def unit_price_to_dollars
    price_string = unit_price.to_s
    dollar_last_index_position = price_string.length - 3
    cents_string = ".#{price_string.length == 1 ? "0" : price_string[-2]}#{price_string[-1]}"
    dollar_string = "$"
    if dollar_last_index_position >= 0
      (0..dollar_last_index_position).each do |index|
        dollar_string += price_string[index]
      end
    else
      dollar_string = "$0"
    end
    dollar_string + cents_string
  end

  def active?
    self.active
  end
end