class AddPaidToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :paid, :boolean, default: false
  end
end
