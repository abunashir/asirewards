class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :certificate, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :quantity
      t.text :note

      t.timestamps null: false
    end
  end
end
