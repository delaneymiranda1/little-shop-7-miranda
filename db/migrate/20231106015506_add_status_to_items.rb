class AddStatusToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :status, :boolean, default: true
  end
end
