class CreateJoinTableCertificateDestination < ActiveRecord::Migration
  def change
    create_join_table :certificates, :destinations do |t|
      # t.index [:certificate_id, :destination_id]
      # t.index [:destination_id, :certificate_id]
    end
  end
end
