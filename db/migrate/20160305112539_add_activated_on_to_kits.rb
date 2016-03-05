class AddActivatedOnToKits < ActiveRecord::Migration
  def change
    add_column :kits, :activated_on, :date
  end
end
