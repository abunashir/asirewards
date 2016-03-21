class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :destination, index: true, foreign_key: true
      t.references :kit, index: true, foreign_key: true
      t.date :check_in
      t.integer :adults
      t.integer :children
      t.string :contact
      t.text :note

      t.timestamps null: false
    end
  end
end
