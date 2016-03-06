class RemoveUserFromCertificates < ActiveRecord::Migration
  def change
    remove_reference :certificates, :user, index: true, foreign_key: true
  end
end
