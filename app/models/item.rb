class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy
  has_many :transactions, through: :invoices, dependent: :destroy
  enum status: { enabled: true, disabled: false }

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


  def best_day
    Item.joins(:transactions)
    .select("invoices.created_at, sum(invoice_items.quantity) as sales")
    .where("invoice_items.item_id = #{self.id} and transactions.result = 0")
    .group('invoices.created_at')
    .order("sales desc, invoices.created_at desc")
    .limit(1).first.created_at.strftime("%d %b %Y")
  end

  def enable
    update(active: true)
  end

  def disable
    update(active: false)
  end
end