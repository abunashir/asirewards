class AddCompanyIdToKits < ActiveRecord::Migration
  def change
    add_reference :kits, :company, index: true, foreign_key: true
  end
end
