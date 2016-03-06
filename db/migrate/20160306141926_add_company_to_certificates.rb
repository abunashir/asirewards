class AddCompanyToCertificates < ActiveRecord::Migration
  def change
    add_reference :certificates, :company, index: true, foreign_key: true
  end
end
