class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :item_name
      t.decimal :item_price
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
