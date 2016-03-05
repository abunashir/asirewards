class AddUserToKits < ActiveRecord::Migration
  def change
    add_reference :kits, :user, index: true, foreign_key: true
  end
end
