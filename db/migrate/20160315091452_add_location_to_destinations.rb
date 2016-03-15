class AddLocationToDestinations < ActiveRecord::Migration
  def change
    add_column :destinations, :location, :string
    add_column :destinations, :country, :string
  end
end
