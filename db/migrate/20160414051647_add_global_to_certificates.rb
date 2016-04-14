class AddGlobalToCertificates < ActiveRecord::Migration
  def change
    add_column :certificates, :global, :boolean, default: false
  end
end
