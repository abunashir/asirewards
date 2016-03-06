class AddCodePrefixToCertificates < ActiveRecord::Migration
  def change
    add_column :certificates, :code_prefix, :string
  end
end
