class AddUserToCertificates < ActiveRecord::Migration
  def change
    add_reference :certificates, :user, index: true, foreign_key: true
  end
end
