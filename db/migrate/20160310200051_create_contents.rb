class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.references :certificate, index: true, foreign_key: true
      t.text :title
      t.text :sub_title
      t.text :terms
      t.text :policies

      t.timestamps null: false
    end
  end
end
