class CreateDistributions < ActiveRecord::Migration
  def change
    create_table :distributions do |t|
      t.references :kit, index: true, foreign_key: true
      t.string :email

      t.timestamps null: false
    end
  end
end
