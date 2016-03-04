class AddUsedToKits < ActiveRecord::Migration
  def change
    add_column :kits, :used, :boolean, null: false, default: false
  end
end
