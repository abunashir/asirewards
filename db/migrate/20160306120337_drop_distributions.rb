class DropDistributions < ActiveRecord::Migration
  def change
    drop_table :distributions do |t|
      t.references :kit, index: true, foreign_key: true
      t.string :name
      t.string :email
      t.integer :sender_id, index: true, foreign_key: true
      t.date :activated_on

      t.timestamps null: false
    end
  end
end
