class AddBookedOnToKits < ActiveRecord::Migration
  def change
    add_column :kits, :booked_on, :date
  end
end
