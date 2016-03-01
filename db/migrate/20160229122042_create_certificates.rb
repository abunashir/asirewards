class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.string :banner
      t.text :title
      t.text :sub_title
      t.text :terms
      t.date :expires_on
      t.decimal :price
      t.text :policies

      t.timestamps null: false
    end
  end
end
