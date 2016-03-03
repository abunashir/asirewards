class CreateKits < ActiveRecord::Migration
  def change
    create_table :kits do |t|
      t.string :code, index: true
      t.references :certificate, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
