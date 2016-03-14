class AddCertificateValidityToCertificates < ActiveRecord::Migration
  def change
    add_column :certificates, :expires_in, :integer
    add_column :certificates, :duration, :integer
  end
end
