class Transaction < ApplicationRecord
  belongs_to :invoice, dependent: :destroy
  
  enum result: { success: 0, failed: 1 }
end