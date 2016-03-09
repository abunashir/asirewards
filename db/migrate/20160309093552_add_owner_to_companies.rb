class AddOwnerToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :owner, :boolean, default: false
  end
end
