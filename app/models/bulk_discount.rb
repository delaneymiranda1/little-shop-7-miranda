class BulkDiscount < ApplicationRecord
  validates_presence_of :quantity, :discount
  belongs_to :merchant
end