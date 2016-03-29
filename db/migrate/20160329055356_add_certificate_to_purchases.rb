class AddCertificateToPurchases < ActiveRecord::Migration
  def change
    add_reference :purchases, :certificate, index: true, foreign_key: true
  end
end
