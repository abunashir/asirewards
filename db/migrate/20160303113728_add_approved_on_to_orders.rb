class AddApprovedOnToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :approved_on, :date
  end
end
