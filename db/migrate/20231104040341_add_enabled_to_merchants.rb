class AddEnabledToMerchants < ActiveRecord::Migration[7.0]
  def change
    add_column :merchants, :enabled, :boolean
  end
end
