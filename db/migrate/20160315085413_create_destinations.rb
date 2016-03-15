class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :name
      t.string :banner
      t.text :content
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
