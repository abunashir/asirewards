class RemoveItemDetailsFromPurchases < ActiveRecord::Migration
  def change
    remove_column :purchases, :item_name, :string
    remove_column :purchases, :item_price, :decimal
  end
end
