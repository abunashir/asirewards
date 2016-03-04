class AddSenderToDistributions < ActiveRecord::Migration
  def change
    add_column :distributions, :sender_id, :integer, index: true, foreign_key: true
  end
end
