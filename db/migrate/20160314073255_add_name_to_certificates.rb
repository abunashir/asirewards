class AddNameToCertificates < ActiveRecord::Migration
  def change
    add_column :certificates, :name, :string
  end
end
