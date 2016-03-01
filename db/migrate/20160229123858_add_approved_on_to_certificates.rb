class AddApprovedOnToCertificates < ActiveRecord::Migration
  def change
    add_column :certificates, :approved_on, :date
  end
end
